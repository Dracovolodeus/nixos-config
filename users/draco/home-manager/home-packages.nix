{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    # Desktop apps
    firefox
    wezterm
    xfce.thunar
    xfce.xfconf
    onlyoffice-desktopeditors
    telegram-desktop
    gimp3-with-plugins
    neohtop
    figma-linux
    throne
    obsidian
    blueman
    imv
    mpv

    jetbrains.idea-community-bin
    jdk21
    gradle_8
    maven

    # Coding stuff
    openssl
    nix-prefetch-github
    nix-index

    python314
    nodejs_24
    uv

    rustc
    cargo

    gcc

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
    # hyprland
    hyprshot
    hyprlock
    hypridle
    waybar
    swww
    dunst
    rofi

    # Sound
    pulseaudio
    pavucontrol
    pamixer
    alsa-utils

    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-emoji-blob-bin

    xdg-utils
  ];
  fonts.fontconfig.enable = true;
}

