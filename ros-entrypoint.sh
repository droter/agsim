#!/bin/bash

source /opt/ros/kinetic/setup.bash
source ~/agsim_ws/devel/setup.bash
source ~/.bashrc
source /etc/bash.bashrc
date >> ~/agsim_ws/logs/roscore.log
roscore & >> ~/agsim_ws/logs/roscore.log 2>&1
sleep 5
exec "$@"
