{ var, ... }: {
  home.sessionVariables = {
    EDITOR = var.program.editor.name;
    TERMINAL = var.program.terminal.name;
    SHELL = var.program.shell.name;
    XCURSOR_SIZE = var.ui.cursor.size;
  };
}
