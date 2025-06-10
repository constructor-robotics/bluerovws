 #!/bin/bash
# this should be executed in the main folder like: sh bashScripts/downloadBasicPackages.sh
# make sure you have access via SSH keys

pushd src/
git clone git@github.com:constructor-robotics/bluespace_ai_xsens_mti_driver.git
git clone git@github.com:constructor-robotics/micron_driver_ros.git
git clone git@github.com:constructor-robotics/ping360_sonar.git
git clone git@github.com:constructor-robotics/ping360_sonar_msgs.git
git clone git@github.com:constructor-robotics/waterlinked_a50.git
git clone git@github.com:constructor-robotics/gui_bluerov.git
git clone git@github.com:constructor-robotics/bluerov2commonmsgs.git
git clone git@github.com:constructor-robotics/bluerov2common.git
#PX4 checkout
git clone -b uuv_bluerov git@github.com:timzarhansen/px4_msgs.git
# this github repo has to be checked out at tag 1.5.0 can be automated too
git clone -b main git@github.com:Auterion/px4-ros2-interface-lib.git


popd