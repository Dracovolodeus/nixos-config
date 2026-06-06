{
  module.system.boot = {
    enable = true;
    kernelPackages = "linuxPackages_7_0";
    kernelParams = [
      "pcie_aspm=off"
    ];
  };
}
