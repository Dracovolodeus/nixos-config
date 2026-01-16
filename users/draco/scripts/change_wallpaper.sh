TARGET_DIR="/nixos-config/users/$USER/assets/wallpapers"
LOCKSCREEN="/nixos-config/users/$USER/assets/lockscreen/image"
HISTORY_FILE="$HOME/.cache/wallpapers_history.custom.txt"

[ -d "$(dirname "$HISTORY_FILE")" ] || mkdir -p "$(dirname "$HISTORY_FILE")"
[ -f "$HISTORY_FILE" ] || touch "$HISTORY_FILE"

mapfile -t all_files < <(find "$TARGET_DIR" -maxdepth 1 -type f -print 2>/dev/null)
[ ${#all_files[@]} -eq 0 ] && exit 0

available_files=()
while IFS= read -r file; do
    [[ -f "$file" ]] || continue
    grep -Fxq "$file" "$HISTORY_FILE" 2>/dev/null || available_files+=("$file")
done < <(printf "%s\n" "${all_files[@]}")

if [ ${#available_files[@]} -eq 0 ]; then
    CURRENT_WALLPAPER=$(tail -n 1 "$HISTORY_FILE" 2>/dev/null || echo "")
    > "$HISTORY_FILE"
    available_files=()
    for f in "${all_files[@]}"; do
        if [[ -f "$f" ]] && [[ "$f" != "$CURRENT_WALLPAPER" ]]; then
            available_files+=("$f")
        fi
    done
    [ ${#available_files[@]} -eq 0 ] && exit 0
fi

selected_file="${available_files[RANDOM % ${#available_files[@]}]}"
echo "$selected_file" >> "$HISTORY_FILE"
ln -fs $selected_file $LOCKSCREEN
swww img $selected_file
