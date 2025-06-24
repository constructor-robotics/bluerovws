#!/bin/bash

# this script has to run from inside "bluerovws" by: source bashScripts/copyROSPackagesToBlueROV.sh
# it copies the desired packages from your local setup to the pis. Ensure that ~/ros_ws/src exists on the pis

copyFolder1_ws () {
#  ssh maintube@$1 mkdir -p ~/ros_ws/src/$2

  rsync -avh src/$2/ maintube@$1:~/ros_ws/src/$2 --exclude=cmake-build-debug --exclude=build --exclude=.git --exclude=.idea --exclude=cmake-build-release --delete
}



copyFolder2_ws () {
#  ssh sensortube@$1 mkdir -p ~/ros_ws/src/$2

  rsync -avh src/$2/ sensortube@$1:~/ros_ws/src/$2 --exclude=cmake-build-debug --exclude=build --exclude=.git --exclude=.idea --exclude=cmake-build-release --delete
}



#Main Tube
IP_ADDRESS="192.168.10.2"

copyFolder1_ws "$IP_ADDRESS" "bluerov2common"
copyFolder1_ws "$IP_ADDRESS" "bluerov2commonmsgs"
copyFolder1_ws "$IP_ADDRESS" "ping360_sonar_msgs"
copyFolder1_ws "$IP_ADDRESS" "micron_driver_ros"
copyFolder1_ws "$IP_ADDRESS" "px4_msgs"
copyFolder1_ws "$IP_ADDRESS" "px4-ros2-interface-lib"
copyFolder1_ws "$IP_ADDRESS" "waterlinked_a50"
copyFolder1_ws "$IP_ADDRESS" "hardware"

#Sensor Tube
IP_ADDRESS="192.168.10.3"

copyFolder2_ws "$IP_ADDRESS" "bluerov2common"
copyFolder2_ws "$IP_ADDRESS" "bluerov2commonmsgs"
copyFolder2_ws "$IP_ADDRESS" "ping360_sonar_msgs"
copyFolder2_ws "$IP_ADDRESS" "micron_driver_ros"
copyFolder2_ws "$IP_ADDRESS" "px4_msgs"
copyFolder2_ws "$IP_ADDRESS" "px4-ros2-interface-lib"
copyFolder2_ws "$IP_ADDRESS" "waterlinked_a50"
copyFolder2_ws "$IP_ADDRESS" "ping360_sonar"
copyFolder2_ws "$IP_ADDRESS" "bluespace_ai_xsens_mti_driver"
copyFolder2_ws "$IP_ADDRESS" "hardware"