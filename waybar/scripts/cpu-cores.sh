#!/bin/bash

# ~/.config/waybar/scripts/cpu-cores.sh

# Получаем данные о загрузке CPU
read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < <(grep 'cpu ' /proc/stat)

# Рассчитываем общую загрузку
total=$((user + nice + system + idle + iowait + irq + softirq + steal + guest + guest_nice))

# Проверяем, что total не равен нулю перед делением
if [ $total -eq 0 ]; then
    load=0
else
    used=$((total - idle - iowait))
    load=$((used * 100 / total))
fi

# Символы для графического представления
bars=("▁" "▂" "▃" "▄" "▅" "▆" "▇")
index=$(( load / 15 ))

# Ограничиваем индекс массива
[ $index -gt 6 ] && index=6

# Формируем вывод для Waybar
echo "{\"text\": \"${bars[$index]} ${load}%\", \"tooltip\": \"CPU Load: ${load}%\"}"
