#!/bin/bash

source /opt/ros/kinetic/setup.bash
source ~/agsim_ws/devel/setup.bash
source ~/.bashrc
date >> ~/agsim_ws/logs/roscore.log

result='ps aux | grep -i "roscore" | grep -v "grep" | wc -l'
if [ $result -ge 1 ]
	then
		echo "roscore is running..."
	else
		echo "starting roscore...."
    roscore & >> ~/agsim_ws/logs/roscore.log 2>&1
fi
sleep 5

exec "$@"
