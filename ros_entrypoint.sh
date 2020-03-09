#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/melodic/setup.bash"


# setup app 
if [ "$PRODUCTION_ENV" == "1" ]; then
    # In production mode
    echo "PRODUCTION MODE"
    APP_SETUP="$HOME/catkin_ws/install/setup.bash"
else
    echo "DEVELOPMENT MODE"
    APP_SETUP="$HOME/catkin_ws/devel/setup.bash"

fi

if [ -f "$APP_SETUP" ]; then
    source "$APP_SETUP"
fi

# Sleep before starting application
if [ -z "$DELAY_START" ]; then
    # DELAY_START env variable not found
    DELAY_START=0
fi
echo "DELAY_START: $DELAY_START seconds."
sleep $DELAY_START

exec "$@"
