{
  lib,
  stdenv,

  cmake,
  fetchFromGitHub,
  versionCheckHook,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "nsproxy";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "nlzy";
    repo = "nsproxy";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Z/xJX2i2jPRo4hPnck2/Bu7ripRASSMt1FAwtSFRErY=";
  };

  strictDeps = true;

  nativeBuildInputs = [ cmake ];

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;
  versionCheckProgramArg = "--version";

  meta = {
    description = "Force applications to use a SOCKS5 or HTTP proxy via Linux namespaces";
    homepage = "https://github.com/nlzy/nsproxy";
    changelog = "https://github.com/nlzy/nsproxy/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.gpl2Plus;
    mainProgram = "nsproxy";
    platforms = lib.platforms.linux;
  };
})
