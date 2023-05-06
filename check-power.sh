#!/bin/bash

# We want to run this periodically and as root.
# So use a systemd timer to start it, and set how often it should run.

FAST_SOUND=/usr/share/sounds/freedesktop/stereo/service-login.oga
SLOW_SOUND=/usr/share/sounds/freedesktop/stereo/service-logout.oga
SPEED_THRESHOLD=20

# Get the current value of the floating point number from the file
current_value=$(cat /tmp/watts)
ryzenadj -i | grep stapm-limit | cut -d\| -f 3 | xargs > /tmp/watts
new_value=$(cat /tmp/watts)

echo $new_value

if [ "$new_value" != "$current_value" ]; then

  # Need this or can;t play sound from root???
  export XDG_RUNTIME_DIR=/run/user/1000
  if (( $(awk 'BEGIN { print ("'$new_value'" < "'$current_value'") }') )); then
    # Going slow, play the slow sound
    echo slow
    pw-play "$SLOW_SOUND"
  else
    echo fast
    pw-play "$FAST_SOUND"
  fi
fi
