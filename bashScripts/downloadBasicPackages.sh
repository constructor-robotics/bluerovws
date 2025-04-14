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
git clone -b release/1.14 git@github.com:PX4/px4_msgs.git



popd