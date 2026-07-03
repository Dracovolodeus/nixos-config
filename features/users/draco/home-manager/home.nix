{
  user,
  pkgs,
  config,
  hmModules,
  homeStateVersion,
  ...
}:
{
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;

  };

  internal.themePath = hmModules.themes.catppuccin.mocha;

  nixpkgs.config.allowUnfree = true;
  imports = [
    # --- CLI --- #
    hmModules.programs.cli.archivers.zip.default
    hmModules.programs.cli.fastfetch.with_aliases
    hmModules.programs.cli.ffmpeg.default
    hmModules.programs.cli.fish.default
    hmModules.programs.cli.git.with_aliases
    hmModules.programs.cli.docker.with_aliases
    hmModules.programs.cli.openssl.default
    hmModules.programs.cli.vfs-tools.tree.default
    hmModules.programs.cli.vfs-tools.lsd.with_aliases
    hmModules.programs.cli.virtualisation.qemu.default

    # --- CLI Development --- #
    # hmModules.programs.cli.dev."c++".default
    # hmModules.programs.cli.dev.go.default
    # hmModules.programs.cli.dev.java.default
    # hmModules.programs.cli.dev.rust.default
    hmModules.programs.cli.dev.js.default
    hmModules.programs.cli.dev.python.default

    # --- TUI --- #
    hmModules.programs.tui.editors.neovim.with_aliases

    # --- GUI --- #
    hmModules.programs.gui.anki.default
    hmModules.programs.gui.browsers.firefox.default
    hmModules.programs.gui.browsers.chromium.default
    hmModules.programs.gui.gimp.default
    hmModules.programs.gui.keepassxc.default
    hmModules.programs.gui.neohtop.default
    hmModules.programs.gui.noctalia.default
    hmModules.programs.gui.obsidian.default
    hmModules.programs.gui.onlyoffice.default
    hmModules.programs.gui.terminals.kitty.default
    hmModules.programs.gui.file-managers.thunar.default
    hmModules.programs.gui.obs-studio.default
    hmModules.programs.gui.fonts.default

    # --- Messengers --- #
    hmModules.programs.gui.messengers.telegram.default
    hmModules.programs.gui.messengers.vesktop.with_proxy

    # --- Games --- #
    hmModules.programs.gui.games.heroic.default
    # hmModules.programs.gui.games.freesmlauncher.default

    # --- Multimedia --- #
    hmModules.programs.gui.media.imv.default
    hmModules.programs.gui.media.mpv.default
    hmModules.programs.gui.media.pavucontrol.default

    # --- System / Environment --- #
    hmModules.programs.wayland-compositors.niri.default

    # Themes #
    hmModules.themes.gtk.default
    hmModules.themes.qt.default
  ];
}
