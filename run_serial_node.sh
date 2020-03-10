#!/bin/bash
if [$MACHINE = LAPTOP]
then
    PORT=/dev/ttyUSB0
elif [$MACHINE = ROBOT]
then
	PORT=/dev/ttyACM0
fi
/ros_entrypoint.sh rosrun rosserial_python serial_node.py $PORT
