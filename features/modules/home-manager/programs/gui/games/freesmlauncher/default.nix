{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [ inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.freesmlauncher ];
}
