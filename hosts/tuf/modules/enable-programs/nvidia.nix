{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;

  powerManagement.enable = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = false;

  # WARNING: DISABLES COMPUTER SLEEP. REQUIRED TO PREVENT ACCIDENTAL SUSPEND ON SYSTEMS WITH MALFUNCTIONING SLEEP MODE.
  systemd.services.nvidia-suspend.enable = false;
  systemd.services.nvidia-hibernate.enable = false;
  systemd.services.nvidia-resume.enable = false;

}
