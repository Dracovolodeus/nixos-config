{ config, ... }:
let
  qtConf = config.internal.theme.qt;
in
{
  qt = {
    enable = true;
    style.name = qtConf.style.name;
    platformTheme.name = qtConf.platformTheme.name;
  };
  home.packages = qtConf.packages;
  xdg.configFile."Kvantum/kvantum.kvconfig".text = qtConf.xdg.configFile.text;
  home.sessionVariables = qtConf.envs;
}
