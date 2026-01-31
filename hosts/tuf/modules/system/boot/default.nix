{
  module.system.boot = {
    enable = true;
    kernelPackages = "linuxPackages_6_18";
    kernelParams = [
      "pcie_aspm=off"
    ];
  };
}
