{ config, pkgs, lib, ... }:

# To learn the new sha256, you need nix-prefetch-github Dracovolodeus DracoNvim --rev HEAD

let
  nvimRepo = pkgs.fetchFromGitHub {
    owner = "Dracovolodeus";
    repo = "DracoNvim";
    rev = "9ef27390fcaadd11058e5824463a5f6b42b40dd2";
    sha256 = "sha256-UPUGTyfLZvYEvp+kdIqZBsX1YP1OXBT7UusQhe3YEn4=";
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
  };

  home.file.".config/nvim" = {
    source = nvimRepo;
    recursive = true;
    onChange = ''
      echo "Обновление конфига NeoVim..."
      ${pkgs.neovim}/bin/nvim -c "Lazy sync" -c "qall"
    '';
  };

  home.activation.installLSP = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    NVIM_DIR="${config.home.homeDirectory}/.config/nvim"
    MASON_MARKER="$NVIM_DIR/.mason-installed"

    # Создаем директорию, если её нет
    mkdir -p "$NVIM_DIR"

    if [[ ! -e "$MASON_MARKER" ]] || \
       [[ "$(cat "$MASON_MARKER" 2>/dev/null)" != "${nvimRepo.rev}" ]]; then
      echo "Установка LSP-серверов через Mason..."
      if ${pkgs.neovim}/bin/nvim -c "MasonInstall pyright lua-language-server rust_analyzer rnix-lsp" -c "qall"; then
        echo "${nvimRepo.rev}" > "$MASON_MARKER"
        echo "LSP-серверы успешно установлены!"
      else
        echo "Ошибка при установке LSP-серверов" >&2
        exit 1
      fi
    else
      echo "LSP-серверы уже установлены (версия ${nvimRepo.rev})"
    fi
  '';

  home.packages = with pkgs; [
    git
    python313Full
    nodejs
    rustc
    cargo
  ];
}
