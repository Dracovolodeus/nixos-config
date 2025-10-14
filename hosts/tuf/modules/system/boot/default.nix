{
  module.system.boot = {
    enable = true;
    kernelPackages = "linuxPackages_6_12";
    kernelParams = [
      "pcie_aspm=off"
    ];
  };
}
