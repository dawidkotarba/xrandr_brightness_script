#!/usr/bin/env bash

function get_monitor_name(){
    local monitor_number=$1
    echo `xrandr --verbose | grep '.*\sconnected' | cut -d " " -f 1 | head -n ${monitor_number} | tail -1`
}

function get_current_brightness(){
   local monitor_number=$1
   echo `xrandr --verbose | grep Brightness | cut -d " " -f 2 | head -n ${monitor_number} | tail -1`
}

function change_brightness(){
    local monitor_number=$1
    local direction=$2
    local monitor_name=`get_monitor_name ${monitor_number}`
    local current_brightness=`get_current_brightness ${monitor_number}`
    local brightness_increase=0.1

    if [[ ${direction} = "up" ]] ; then
        local new_brightness=`echo ${current_brightness}+${brightness_increase} | bc`

    else
        local new_brightness=`echo ${current_brightness}-${brightness_increase} | bc`
    fi
        xrandr --output ${monitor_name} --brightness ${new_brightness}
}

# Increase brightness for first monitor: change_brightness 1 up
# Decrease brightness for first monitor: change_brightness 1 down
change_brightness $1 $2