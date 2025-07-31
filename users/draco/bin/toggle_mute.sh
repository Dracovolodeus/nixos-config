#!/bin/bash

# Получаем текущее состояние звука
MUTE_STATE=$(amixer get Master | grep -oE '\[on\]|\[off\]' | head -n 1)

if [ "$MUTE_STATE" = "[off]" ]; then
    # Если звук выключен, включаем его
    amixer set Master unmute
    echo "Звук включен."
else
    # Если звук включен, выключаем его
    amixer set Master mute
    echo "Звук выключен."
fi
