#!/bin/bash

# time in seconds
time=1530

# state file
state_file="/var/tmp/suspend_state"

while true; do
    # wait for the defined time
    sleep $time

    # check if the suspension was initiated manually before the scheduled suspension time
    if [ -f "$state_file" ]; then
        state_time=$(stat -c %Y "$state_file")
        current_time=$(date +%s)
        if (( $current_time - $state_time < $time )); then
            time=$(( $state_time + $time - $current_time ))
            continue
        fi
    fi

    # show a notification that the system is about to suspend
    notify-send -u critical -a 'Suspender' -i '/usr/share/icons/hicolor/scalable/actions/libpeas-plugin.svg' -t 30000  "System will suspend in 30 seconds" 

    # wait for 30 seconds before suspending
    sleep 30

    # suspend the system
    systemctl suspend

    # update the state file
    touch "$state_file"

    # reset the timer after manual or general suspension
    time=1530
done
