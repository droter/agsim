
sudo rosdep fix-permissions
rosdep update
rosdep install --default-yes --from-paths . --ignore-src --rosdistro $ROSDISTRO

# install Arduino IDE
RUN curl https://downloads.arduino.cc/arduino-1.8.5-linux64.tar.xz > ./arduino-1.8.5-linux64.tar.xz \
 && unxz ./arduino-1.8.5-linux64.tar.xz \
 && tar -xvf arduino-1.8.5-linux64.tar \
 && rm -rf arduino-1.8.5-linux64.tar \
 && cd /arduino-1.8.5 \
 && ./install.sh

# install Cloud9 IDE
# Install Node.js
curl -sL https://deb.nodesource.com/setup | bash -
apt-get install -y nodejs

# Install Cloud9
git clone https://github.com/c9/core.git /opt/cloud9
cd /opt/cloud9
scripts/install-sdk.sh
npm install

# Tweak standlone.js conf
sed -i -e 's_127.0.0.1_0.0.0.0_g' /opt/cloud9/configs/standalone.js 


# Environment Configuration
export PYTHONPATH=$PYTHONPATH:/usr/lib/python2.7/dist-packages
echo "source /opt/ros/$ROSDISTRO/setup.bash" >> ~/.bashrc
source ~/.bashrc 

# Verify ROS workspace
if [ ! -d "~/agsim_ws" ]; then
  mkdir -p ~/agsim_ws/src
  cd ~/agsim_ws/src/ && \
  catkin_init_workspace && \
fi

# Install ROS-A Simulator
cd ~/agsim_ws/src/
git clone https://github.com/ros-agriculture/microtrac_simulator.git
cd ../ && catkin_make -j4
echo ". ~/agsim_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc 

echo ""
echo "ROS $(rosversion -d) Installation Done!"
echo "You can create your catkin workspace now. https://wiki.ros.org/catkin/Tutorials/create_a_workspace"
