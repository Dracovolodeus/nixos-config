{ pkgs, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    # Desktop apps
    firefox
    wezterm
    xfce.thunar
    xfce.xfconf
    onlyoffice-desktopeditors
    inputs.freesmlauncher.packages.${pkgs.system}.freesmlauncher
    telegram-desktop
    gimp3-with-plugins
    neohtop
    figma-linux
    throne
    obsidian
    blueman
    imv
    mpv

    # Coding stuff
    openssl
    nix-prefetch-github
    nix-index

    python314
    nodejs_24
    uv

    rustc
    cargo

    jetbrains.idea-community-bin
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
    hyprland
    hyprshot
    hyprlock
    hypridle
    waybar
    swww
    dunst
    rofi

    # Sound
    pipewire
    pavucontrol

    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-emoji-blob-bin

    xdg-utils
  ];
  fonts.fontconfig.enable = true;
}

