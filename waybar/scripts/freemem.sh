#!/bin/bash
used_percent=$(free -m | awk '/Mem/ {printf "%.1f", $3/$2 * 100}')
echo "{\"text\": \"$used_percent%\"}"
