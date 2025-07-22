{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelParams = [
  #   "acpi_backlight=native"
  #   "acpi_osi=Linux"
  #   "nvme_core.default_ps_max_latency_us=5500"
  #   "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  #   "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  #   "nvidia.NVreg_EnablePCIeGen3=1"
  #   "pcie_port_pm=off"
  #   "resume_offset=0"
  # ];
  #
  # systemd.services.systemd-suspend.environment = {
  #   SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  # };
  #
  # systemd.services."nvidia-suspend".enable = false;
  # systemd.services."nvidia-hibernate".enable = false;
  # systemd.services."nvidia-resume".enable = false;
  #
  # systemd.services."systemd-suspend".enable = true;
}
