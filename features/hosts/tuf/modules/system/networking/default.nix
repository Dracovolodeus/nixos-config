{ hostName, ... }: {
  networking = {
    hostName = hostName;
    nftables.enable = true;

    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
        macAddress = "random";
        backend = "iwd";
      };
    };

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
      allowPing = false;
      checkReversePath = "loose";
    };
  };
}
