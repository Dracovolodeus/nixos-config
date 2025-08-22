{
  boot.loader = {
    # systemd-boot.enable = false;  # Явно отключаем systemd-boot
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };
}
