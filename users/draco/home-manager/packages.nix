{ pkgs, unstable, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    # Desktop apps
    # inputs.freesmlauncher.packages.${pkgs.system}.freesmlauncher
    firefox
    wezterm
    ghostty
    anki
    thunar
    xfconf
    onlyoffice-desktopeditors
    telegram-desktop
    gimp3-with-plugins
    qemu
    keepassxc
    obs-studio
    neohtop
    # throne
    obsidian
    blueman
    furmark
    imv
    mpv


    # Coding stuff
    openssl
    nix-prefetch-github
    nix-index

    go

    python314
    nodejs_24
    uv

    rustc
    cargo

    jdk21
    gradle_8
    maven

    gcc
    glib

    # CLI utils
    wf-recorder
    wl-clipboard
    git
    tree
    fastfetch
    zip
    unzip
    ffmpeg
    cava
    inxi
    bluez
    bluez-tools
    playerctl
    brightnessctl

    jq
    socat

    # WM and stuff
    awww
    rofi

    # Sound
    pipewire
    pavucontrol

    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-emoji-blob-bin

    niri
    xwayland-satellite
    xdg-utils
    quickshell
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
  ];

  fonts.fontconfig.enable = true;
}
