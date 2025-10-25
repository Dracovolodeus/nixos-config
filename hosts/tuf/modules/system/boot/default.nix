{
  module.system.boot = {
    enable = true;
    kernelPackages = "linuxPackages_6_17";
    kernelParams = [
      "pcie_aspm=off"
    ];
  };
}
