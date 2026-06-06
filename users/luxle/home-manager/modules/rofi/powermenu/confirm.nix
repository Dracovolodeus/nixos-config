{
  home.file.".config/rofi/powermenu/confirm.rasi".text = ''
    * {
        bg-col: #181825;
        bg-col-light: #313244;
        fg-col: #cdd6f4;
        selected-col: #b4befe;
        cfont: "JetBrainsMono Nerd Font 48";
    }

    window {
        location: center;
        anchor: center;
        width: 550px;
        background-color: @bg-col;
        border-radius: 20px;
        cursor: "default";
    }

    mainbox {
        spacing: 30px;
        padding: 30px;
        background-color: transparent;
        children: [ "message", "listview" ];
    }

    listview {
        lines: 1;
        columns: 2;
        dynamic: true;
        scrollbar: false;
        reverse: false;
        layout: vertical;
        cycle: true;
        fixed-columns: true;
        fixed-height: true;
    
        spacing: 25px;
        background-color: transparent;
        text-color: @fg-col;
        cursor: "default";
    }

    message {
        margin: 0px;
        padding: 20px;
        border-radius: 20px;
        background-color: @bg-col-light;
        text-color: @fg-col;
    }

    textbox {
        background-color: inherit;
        text-color: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.5;
        placeholder-color: @fg-col;
        blink: true;
        markup: true;
    }

    element {
        padding: 60px 10px;
        text-color: @fg-col;
        border-radius: 20px;
        background-color: @bg-col-light;
        cursor: pointer;
    }

    element selected.normal {
        text-color: @bg-col;
        background-color: @selected-col;
    }

    element-text {
        font: @cfont;
        text-color: inherit;
        background-color: transparent;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.5;
    }'';
}
