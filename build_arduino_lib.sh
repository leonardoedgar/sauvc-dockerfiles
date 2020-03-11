#!/bin/bash
rm -rf ros_lib
/ros_entrypoint.sh rosrun rosserial_arduino make_libraries.py .
