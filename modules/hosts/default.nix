{lib, ...}: {
  imports = let
    allFiles = lib.filesystem.listFilesRecursive ./.;
    nixFiles = lib.filter
      (file: file != ./default.nix && lib.strings.hasSuffix ".nix" file)
      allFiles;
  in nixFiles;
}
