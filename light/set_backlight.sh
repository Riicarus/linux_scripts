#!/bin/bash

acpi_light_path="/sys/class/backlight/nvidia_wmi_ec_backlight"
max_light=`cat $acpi_light_path/max_brightness`

light=$1
if [[ $light -gt $max_light ]]; then light=$max_light; fi

echo $light > $acpi_light_path/brightness

if [[ $? -ne 0 ]] 
then echo "fail"
else echo "set light to $light"
fi
