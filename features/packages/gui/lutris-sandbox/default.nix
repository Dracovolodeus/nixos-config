{
  lib,
  writeShellApplication,

  bubblewrap,
  coreutils,
  util-linux,
}:
writeShellApplication {
  name = "lutris-sandbox-unwrapped";
  runtimeInputs = [
    bubblewrap
    coreutils
    util-linux
  ];
  text = builtins.readFile ./launcher.sh;

  meta = {
    description = "Per-game Bubblewrap launcher for Lutris Proton games";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
