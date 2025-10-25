{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    # Desktop apps
    firefox
    wezterm
    xfce.thunar
    xfce.xfconf
    libsForQt5.kdeconnect-kde
    onlyoffice-desktopeditors
    telegram-desktop
    cassette
    gimp3-with-plugins
    neohtop
    figma-linux
    nekoray
    nwg-look
    obsidian
    blueman
    imv
    mpv

    # Coding stuff
    openssl
    nix-prefetch-github
    nix-index

    python313Full
    nodejs_24
    uv

    lua

    rustc
    cargo

    gcc
    glib

    # CLI utils
    wf-recorder
    wl-clipboard
    bat
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

xdg-utils
  ];
  fonts.fontconfig.enable = true;
}

