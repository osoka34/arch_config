#!/bin/bash
stats=$(vmstat -s)
total=$(echo "$stats" | awk '/total memory/ {print $1}')
used=$(echo "$stats" | awk '/used memory/ {print $1}')
used_percent=$((used * 100 / total))

if [ $used_percent -gt 90 ]; then
    color="#ff0000"
elif [ $used_percent -gt 70 ]; then
    color="#ffff00"
else
    color="#00ff00"
fi

# echo "{\"text\": \"󰍛 ${used_percent}%\", \"style\": \"color: $color\"}"

# Конвертация в GB
total_gb=$(echo "scale=1; $total / 1048576" | bc)
used_gb=$(echo "scale=1; $used / 1048576" | bc)

echo "{\"text\": \"󰍛 ${used_gb}G/${total_gb}G\", \"style\": \"color: $color\"}"
