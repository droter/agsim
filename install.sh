#!/usr/bin/env bash

set -e

apt-get -y install sudo apt-utils

sudo apt-get -y install software-properties-common python-software-properties
sudo add-apt-repository ppa:git-core/ppa
add-apt-repository universe
apt-get -y update

apt-get -y install zsh screen tree ssh synaptic \
    vim minicom git wget gawk make curl cmake unzip \
    apt-transport-https ca-certificates iputils-ping dpkg 
    
# Additional development tools
apt-get install -y x11-apps python-pip build-essential lsb-release
sudo -H pip install --upgrade pip
pip install catkin_tools
pip install pyparsing==1.5.7

# installing interactive time zone
export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive
apt-get -y install tzdata
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# demo tools Jupyter Notebook
apt-get -y install ipython ipython-notebook
sudo -H pip install jupyter

# Chrome web browser
apt-get -y install fonts-liberation libappindicator1 libasound2
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get -y install libgconf2-4 libnss3-1d libxss1
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -fy install

ARCH=$(uname -i)
RELEASE=$(lsb_release -c -s)

if [ $RELEASE == "trusty" ]
    then
        ROSDISTRO=indigo
        echo Installing ros-$ROSDISTRO

elif [ $RELEASE == "xenial" ]
    then
        ROSDISTRO=kinetic
        echo Installing ros-$ROSDISTRO
else
    echo "There's no ROS Distro compatible for your platform"
    exit 1
fi

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update

if [ $ARCH == "x86_64" ]
    then
        sudo apt-get -y install ros-$ROSDISTRO-desktop-full
        echo "Installing ROS-$ROSDISTRO Full Desktop Version"
        
        sudo apt-get -y install ros-$ROSDISTRO-gazebo-*
        rm -rf /var/lib/apt/lists/*
        echo "Installing Gazebo Full Desktop Version"

else  
    sudo apt-get -y install ros-$ROSDISTRO-ros-base
    echo "Installing ROS-$ROSDISTRO Barebones"
fi

sudo apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

echo ". /opt/ros/$ROSDISTRO/setup.bash" >> ~/.bashrc && \
. /opt/ros/$ROSDISTRO/setup.sh

sudo apt-get install python-rosdep -y
sudo `which rosdep` init



