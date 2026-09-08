{
  services.asusd.enable = true;

  # The inactive ACPI video bus duplicates the laptop brightness hotkeys.
  services.udev.extraRules = ''
    ACTION!="remove", SUBSYSTEM=="input", KERNEL=="event[0-9]*", KERNELS=="0000:00:08.1", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
}
