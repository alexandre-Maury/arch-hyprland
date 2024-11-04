#!/bin/bash

governors=("performance" "powersave" "userspace" "ondemand" "conservative" "schedutil")
governor=$(printf "%s\n" "${governors[@]}" | rofi -dmenu)
sudo -A cpupower frequency-set -g "$governor"