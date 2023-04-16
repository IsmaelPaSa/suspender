#!/bin/bash

# time in seconds
time=1500

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

    # suspend the system
    systemctl suspend

    # update the state file
    touch "$state_file"

    # reset the timer after manual or general suspension
    time=1500
done
