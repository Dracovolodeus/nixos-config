{ var, ... }: {
  home.file.".config/rofi/powermenu/powermenu.sh".text = ''

#!/usr/bin/env bash

dir="/home/${var.user}/.config/rofi/powermenu"
theme='powermenu'

# System info
uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

# Icons
shutdown=''
reboot=''
lock=''
suspend=''
logout=''
yes=''
no=''

# ---------------------- #
# Functions for actions  #
# ---------------------- #

confirm_action() { # Confirm
    local action_name="$1"
    echo -e "$yes\n$no" | rofi -dmenu \
        -p "Confirm $action_name" \
        -mesg "Are you sure?" \
        -theme "''${dir}/confirm.rasi"
}

lock_screen() { # Lock
    if [[ $(confirm_action "logout") == "$yes" ]]; then
        hyprlock
    fi
}

poweroff_system() { # Poweroff
    if [[ $(confirm_action "shutdown") == "$yes" ]]; then
        systemctl poweroff
    fi
}

reboot_system() { # Reboot
    if [[ $(confirm_action "reboot") == "$yes" ]]; then
        systemctl reboot
    fi
}

suspend_system() { # Suspend
    if [[ $(confirm_action "suspend") == "$yes" ]]; then
        systemctl suspend
    fi
}

logout_session() { # Logout
    if [[ $(confirm_action "logout") == "$yes" ]]; then
        loginctl kill-session ''${XDG_SESSION_ID}
    fi
}

# -------------- #
# Main interface #
# -------------- #

show_menu() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu \
        -theme "''${dir}/''${theme}.rasi"
}

# ----------- #
# Entry point #
# ----------- #

case $(show_menu) in
    # Icon: func
    "$shutdown") poweroff_system ;;
    "$reboot") reboot_system ;;
    "$lock") lock_screen ;;
    "$suspend") suspend_system ;;
    "$logout") logout_session ;;
esac
  '';
}
