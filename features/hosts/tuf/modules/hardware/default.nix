{

  hardware = {
    enableAllFirmware = true;
    # enableAllHardware = true;
    # enableRedistributableFirmware = true;
    firmwareCompression = "zstd";
  };

  imports = [
    ./cpu
    ./gpu
    ./ram
    ./ssd
  ];
}
