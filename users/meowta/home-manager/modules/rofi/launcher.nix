{ var, ... }: {
  home.file.".config/rofi/launcher.rasi".text = ''configuration {
    modi: "run,drun";
    lines: 5;
    font: "JetBrainsMono Nerd Font 14";
    show-icons: true;
    terminal: "${var.terminal}";
    drun-display-format: "{icon} {name}";
    location: 0;
    disable-history: false;
    hide-scrollbar: true;
    display-drun: "   Apps ";
    display-run: "   Run ";
    sidebar-mode: true;
}

* {
    bg-col:  rgb(30, 29, 47);
    bg-col-light: rgb(30, 29, 47);
    border-col: rgb(24, 24, 38);
    selected-col: rgb(24, 24, 38);
    blue: rgb(122, 162, 247);
    fg-col: rgb(122, 162, 247);
    fg-col2: rgb(242, 143, 173);
    grey: rgb(217, 224, 238);
    selected-button: rgb(24, 24, 38);
    width: 600;
}

element-text, element-icon , mode-switcher {
    background-color: inherit;
    text-color:       inherit;
}

window {
    height: 360px;
    border: 3px;
    border-color: @border-col;
    background-color: @bg-col;
}

mainbox {
    background-color: @bg-col;
}

inputbar {
    children: [prompt,entry];
    background-color: @bg-col;
    border-radius: 5px;
    padding: 2px;
}

prompt {
    background-color: @blue;
    padding: 6px;
    text-color: @bg-col;
    border-radius: 3px;
    margin: 20px 0px 0px 20px;
}

textbox-prompt-colon {
    expand: false;
    str: ":";
    content: "";
}

entry {
    padding: 6px;
    margin: 20px 0px 0px 10px;
    text-color: @fg-col;
    background-color: @bg-col;
    placeholder:"Search";
}


listview {
    border: 0px 0px 0px;
    padding: 6px 0px 0px;
    margin: 10px 0px 0px 20px;
    columns: 2;
    background-color: @bg-col;
}

element {
    padding: 5px;
    background-color: @bg-col;
    text-color: @fg-col  ;
}

element-icon {
    size: 25px;
}

element selected {
    background-color:  @selected-col ;
    text-color: @fg-col2  ;
}

mode-switcher {
    spacing: 0;
  }

button {
    padding: 10px;
    background-color: @bg-col-light;
    text-color: @grey;
    vertical-align: 0.5; 
    horizontal-align: 0.5;
}

button selected {
  background-color: @selected-button;
  text-color: @blue;
}'';
}
