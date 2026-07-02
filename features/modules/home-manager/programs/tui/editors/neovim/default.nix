{ pkgs, lib, ... }: {
  home = {
    packages = with pkgs; [ neovim ];
    sessionVariables.EDITOR = lib.getExe pkgs.neovim;
  };
}
