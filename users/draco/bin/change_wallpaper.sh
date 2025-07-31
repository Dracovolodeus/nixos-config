#!/bin/bash

# Укажите директорию
DIRECTORY="/nixos-config/users/$USER/wallpapers"

# Выбор случайного файла
RANDOM_FILE=$(ls "$DIRECTORY" | shuf -n 1)

swww img "$DIRECTORY/$RANDOM_FILE"
