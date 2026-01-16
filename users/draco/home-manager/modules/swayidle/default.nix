{ pkgs, var, ... }: {
  services.swayidle = {
    enable = true;
    extraArgs = [ "-w" ];
    timeouts = [
      {
        timeout = 630;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        resumeCommand = "${pkgs.niri}/bin/niri msg action power-on-monitors";
      }

      {
        timeout = 1200;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }

      { 
        timeout = 2700;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -c /home/${var.user}/.config/swaylock";
      }
      {
        event = "before-sleep";
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
    ];
  };
}
