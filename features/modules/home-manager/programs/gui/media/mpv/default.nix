{ pkgs, ... }: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [ mpris ];
    bindings = {
      "]" = "add speed 0.25";
      "[" = "add speed -0.25";
    };
  };
}
