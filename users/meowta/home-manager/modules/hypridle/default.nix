{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [

        {
          timeout = 1185;
          on-timeout = "loginctl lock-session";
        }

        {
          timeout = 1215;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        {
          timeout = 2700;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
