{ pkgs, ... }: {
  boot = {
    consoleLogLevel = 0;

    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [
      "amd_iommu=pt"
      "nvidia.NVreg_EnableS0ixPowerManagement=1"

      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"

    ];

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 4;
      };
      efi.canTouchEfiVariables = true;
    };

    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
  };
}
