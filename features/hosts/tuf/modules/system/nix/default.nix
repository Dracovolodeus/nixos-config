{
  nix = {
    settings = {
      warn-dirty = false;
      connect-timeout = 4;
      stalled-download-timeout = 4;
      download-attempts = 2;
      fallback = true;
      extra-substituters = [
        "https://cache.nixos.org?priority=1"
        "https://ncproxy.vizqq.cc?priority=2"
        "https://cache.nixos.kz?priority=3"
        "https://nixos-cache-proxy.cofob.dev?priority=4"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=5"
        "https://nixos-cache-proxy.sweetdogs.ru?priority=6"
      ];

      sandbox = true;
      auto-optimise-store = true;

      experimental-features = [
        "flakes"
        "nix-command"
      ];
      allowed-users = [ "*" ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
