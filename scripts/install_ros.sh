
#!/bin/bash
#----------------------------------------------------------
# Purpose:
#    Installs ROS (Robot Operating System), and a few addional
#    dependencies / compiled packages required for the agsim.
#----------------------------------------------------------
# Acknowledgements / References:
#    This script comes largely from:
#      https://github.com/AurelienRoy/ardupilot_sitl_ros_tutorial/blob/master/scripts/step_4_install_ros.sh
#    With some commands inspired from:
#      http://wiki.ros.org/kinetic/Installation/Ubuntu
#----------------------------------------------------------

# Note:
#    Sometimes, if the system was not perfectly clean before, the installation
#    fails because of mesa packages interlocks.
#    In such case, you can try to install them manually by typing in a terminal:
#
#  sudo apt-get install xserver-xorg-dev-lts-utopic mesa-common-dev-lts-utopic libgles2-mesa-dev-lts-utopic libgles1-mesa-dev-lts-utopic libgl1-mesa-dev-lts-utopic libegl1-mesa-dev-lts-utopi
#
#    and then re-run this script. (Good luck, this problem is a real pain !)
#    Solution seen on:
#     http://askubuntu.com/questions/588695/cant-install-libglew-dev-because-libcheese-and-libclutter-dont-have-the-requir


# Stops at the first error it encounters
set -e

export DEBIAN_FRONTEND=noninteractive

## add ROS repository and key
## install main ROS pacakges
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-key 0xB01FA116
#wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
sudo apt-get update

# In case there was a missing dependency, you may try the following line.
# However, be careful not to attempt to desinstall-reinstall libgl1-mesa,
# for it sometimes messes up the ubuntu installation.
#   sudo apt-get -y install libgl1-mesa-dev-lts-utopic

sudo apt-get -y install ros-kinetic-desktop-full

sudo rosdep init
rosdep update

## setup environment variables
sudo sh -c 'echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc'
source ~/.bashrc

## get rosinstall and some additional dependencies
sudo apt-get -y install python-rosinstall          \
                        ros-kinetic-octomap-msgs    \
                        ros-kinetic-joy             \
                        ros-kinetic-geodesy         \
                        ros-kinetic-octomap-ros     \
                        unzip
			

RED='\033[0;32m'
NC='\033[0m' # No Color
printf "${RED}ROS is now installed \n${NC}"
printf "${RED}You should close this terminal and open a new one before launching next script\n${NC}"






