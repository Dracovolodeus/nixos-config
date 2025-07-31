{ var, ... }: {
  home.sessionVariables = {
    EDITOR = var.editor;
    TERMINAL = var.terminal;
    XCURSOR_SIZE = var.cursorSize;
    SHELL = var.shell;
  };
}
