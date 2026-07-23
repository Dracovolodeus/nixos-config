{
  lib,
  stdenv,

  buildGoModule,
  fetchFromGitHub,
  fetchurl,
  makeDesktopItem,

  protobuf,
  protoc-gen-go,
  protoc-gen-go-grpc,

  cmake,
  copyDesktopItems,
  ninja,

  qt6Packages,

  # Override to use a newer ruleset with its corresponding hash.
  throne-srslist ? fetchurl {
    url = "https://raw.githubusercontent.com/throneproj/routeprofiles/0e22b8ab8a276024eb0e0e3d9d72a2e7560f8412/srslist.h";
    hash = "sha256-YniOn4RGJ+VTHnxqNs7kKO/WaPNw8/Jn+6Y4+TphkFk=";
  },
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "throne";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "throneproj";
    repo = "Throne";
    tag = finalAttrs.version;
    hash = "sha256-y5040RMg3gj/oAznE7geohF4Oq4kX05baJFPmy5Qlvs=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    copyDesktopItems
    ninja
    qt6Packages.wrapQtAppsHook
  ];

  buildInputs = [
    qt6Packages.qtbase
    qt6Packages.qttools
  ];

  env.INPUT_VERSION = finalAttrs.version;

  # Suppress errors in 3rdparty/simple-protobuf.
  env.NIX_CFLAGS_COMPILE = "-Wno-error=maybe-uninitialized";

  patches = [
    # Use the NixOS security wrapper rather than attempting to set suid.
    ./nixos-disable-setuid-request.patch
    # The generated autostart desktop file must use the Qt wrapper from PATH.
    ./fix-autorun-desktop-exec.patch
    # Qt 6.11 marks QMetaObject::invokeMethod results nodiscard.
    ./fix-utils-nodiscard.patch
  ];

  preBuild = ''
    ln -s ${throne-srslist} ./srslist.h
  '';

  # The wrapper below supplies both Qt paths and a writable application directory.
  dontWrapQtApps = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 Throne -t "$out/share/throne/"
    install -Dm644 "$src/res/public/Throne.png" -t "$out/share/icons/hicolor/512x512/apps/"

    makeQtWrapper "$out/share/throne/Throne" "$out/bin/Throne" \
      --append-flag "-appdata"

    ln -s ${finalAttrs.passthru.core}/bin/ThroneCore "$out/share/throne/ThroneCore"
    # NixOS 26.05's module still refers to this legacy filename for its wrapper.
    ln -s ThroneCore "$out/share/throne/Core"

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "throne";
      desktopName = "Throne";
      exec = "Throne";
      icon = "Throne";
      comment = finalAttrs.meta.description;
      terminal = false;
      categories = [ "Network" ];
    })
  ];

  passthru.core = buildGoModule {
    pname = "throne-core";
    inherit (finalAttrs) version src;
    sourceRoot = "${finalAttrs.src.name}/core/server";

    patches = [
      # Also check CAP_NET_ADMIN so the core works with NixOS capabilities.
      ./core-also-check-capabilities.patch
      # The NixOS security wrapper and the GUI live in separate store directories.
      ./core-relax-parent-check.patch
    ];

    proxyVendor = true;
    vendorHash = "sha256-3WKCdmKj1lATR0nDk3Jxd4BMrPzsXCnGtoWeMAw06XY=";

    nativeBuildInputs = [
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
    ];

    # Taken from script/build_go.sh.
    preBuild = ''
      pushd gen
      protoc -I . --go_out=. --go-grpc_out=. libcore.proto
      popd

      VERSION_SINGBOX=$(go list -m -f '{{.Version}}' github.com/sagernet/sing-box)
      ldflags+=("-X 'github.com/sagernet/sing-box/constant.Version=$VERSION_SINGBOX'")
    '';

    # ldflags and tags are taken from script/build_go.sh.
    ldflags = [
      "-w"
      "-s"
      "-X"
      "internal/godebug.defaultGODEBUG=multipathtcp=0"
      "-checklinkname=0"
    ];

    tags = [
      "with_clash_api"
      "with_gvisor"
      "with_quic"
      "with_wireguard"
      "with_utls"
      "with_dhcp"
      "with_tailscale"
      "badlinkname"
      "tfogo_checklinkname"
      "with_naive_outbound"
      "with_purego" # Prebuilt .a files inside cronet-go are impractical to fix.
    ];
  };

  # This lets nix-update update the vendorHash of passthru.core as well.
  passthru.goModules = finalAttrs.passthru.core.goModules;

  meta = {
    description = "Qt based cross-platform GUI proxy configuration manager";
    homepage = "https://github.com/throneproj/Throne";
    license = lib.licenses.gpl3Plus;
    mainProgram = "Throne";
    maintainers = with lib.maintainers; [
      tomasajt
      aleksana
    ];
    platforms = lib.platforms.linux;
  };
})
