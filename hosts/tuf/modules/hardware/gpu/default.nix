{
  # WARNING: DISABLES COMPUTER SLEEP. REQUIRED TO PREVENT ACCIDENTAL SUSPEND ON SYSTEMS WITH MALFUNCTIONING SLEEP MODE.
  systemd.services.nvidia-suspend.enable = false;
  systemd.services.nvidia-hibernate.enable = false;
  systemd.services.nvidia-resume.enable = false;
  module.hardware.gpu = {
    enable = true;
    nvidia = {
      enable = true;
    };
  };
}
