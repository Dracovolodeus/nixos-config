{ pkgs, ... }: {

  services.udev.packages = [ pkgs.android-udev-rules ];
  services.gvfs.enable = true;
  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    gvfs
    libmtp
    mtpfs
    jmtpfs
  ];
}
