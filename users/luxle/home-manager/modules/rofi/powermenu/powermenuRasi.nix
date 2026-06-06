{
  home.file.".config/rofi/powermenu/powermenu.rasi".text = ''
    		
    * {
        /* For resolution : 1920x1080 */
        background: #181825;
        background-alt: #313244;
        foreground: #cdd6f4;
        selected: #b4befe;
        active: #ABE9B3FF;
        urgent: #F28FADFF;
        cfont: "JetBrains Mono Nerd Font 48";
        box-spacing: 50px;
        box-margin: 370px 350px;
        message-margin: 0px 350px;
        inputbar-spacing: 0px;
        list-spacing: 50px;
        element-radius: 20px;
        general-radius: 100%;
        general-padding: 20px;
        element-padding: 55px 10px;
    }

    window {
        transparency: "real";
        location: center;
        anchor: center;
        fullscreen: true;
        width: 1366px;
        x-offset: 0px;
        y-offset: 0px;
        enabled: true;
        margin: 0px;
        padding: 0px;
        border: 0px solid;
        border-radius: 0px;
        border-color: @selected;
        background-color: @background;
    }

    mainbox {
        enabled: true;
        spacing: @box-spacing;
        margin: 0px;
        padding: @box-margin;
        border: 0px solid;
        border-radius: 0px;
        border-color: @selected;
        background-color: transparent;
        children: [ "message", "listview" ];
    }

    listview {
        enabled: true;
        columns: 5;
        lines: 1;
        cycle: true;
        dynamic: true;
        scrollbar: false;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: true;
        spacing: @list-spacing;
        margin: 0px;
        padding: 0px;
        border: 0px solid;
        border-radius: 0px;
        border-color: @selected;
        background-color: transparent;
        text-color: @foreground;
        cursor: "default";
    }

    element {
        enabled: true;
        spacing: 0px;
        margin: 0px;
        padding: @element-padding;
        border: 0px solid;
        border-radius: @element-radius;
        border-color: @selected;
        background-color: @background-alt;
        text-color: @foreground;
        cursor: pointer;
    }
    element-text {
        font: @cfont;
        background-color: transparent;
        text-color: inherit;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.5;
    }
    element selected.normal {
        background-color: @selected;
        text-color: @background;
    }
    	'';
}
