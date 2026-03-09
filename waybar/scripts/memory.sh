#!/bin/bash

# Получаем данные из /proc/meminfo
total=$(grep "MemTotal" /proc/meminfo | awk '{print $2}')
available=$(grep "MemAvailable" /proc/meminfo | awk '{print $2}')

# Конвертируем в гигабайты (для альтернативного формата)
# total_gb=$(echo "scale=2; $total / 1048576" | bc)
# available_gb=$(echo "scale=2; $available / 1048576" | bc)

# Рассчитываем процент использования
used_percent=$((100 - (available * 100) / total))

# Форматируем вывод для Waybar
echo "{\"text\": \"$used_percent%\", \"tooltip\": \"Использовано: $used_percent%\"}"
