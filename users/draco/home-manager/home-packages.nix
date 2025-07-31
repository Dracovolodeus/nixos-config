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
    nwg-look
    obsidian
    blueman
    imv
    mpv

    # Coding stuff
    openssl
    nix-prefetch-github

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
    brightnessctl
    # qemu

    qemu_kvm
    virt-manager
    virt-viewer
    spice-vdagent
    OVMF
    swtpm

    jq
    socat

    # WM and stuff
    hyprland
    hyprshot
    hyprlock
    hypridle
    waybar
    eww
    swww
    dunst
    rofi

    # Sound
    pulseaudio
    pavucontrol
    pamixer
    alsa-utils

    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.enable = true;
}
