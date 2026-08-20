#!/bin/bash
# Debug + fix helper for the cv_bridge include issue in the bluerovws devcontainer.
# Run INSIDE the container (as bluerovuser) from anywhere:
#   bash bashScripts/debugCvBridge.sh
# Applies the compatibility symlink (idempotent) and verifies the build.
#
# Background: the arm64 (Apple Silicon / Raspberry Pi) builds of the ROS Humble
# packages are repackaged from a newer source snapshot with the *new* nested
# header layout (include/cv_bridge/cv_bridge/cv_bridge.h), while the packages in
# src/ include the classic <cv_bridge/cv_bridge.hpp>. The compatibility symlink
# makes both layouts work on the same image.

set -u

echo "== 1. Header layout =="
ls -la /opt/ros/humble/include/cv_bridge/

echo
echo "== 2. Applying compatibility symlink (nested level - matches the build's -isystem prefix) =="
sudo ln -sf cv_bridge.h /opt/ros/humble/include/cv_bridge/cv_bridge/cv_bridge.hpp
ls -la /opt/ros/humble/include/cv_bridge/cv_bridge/cv_bridge.hpp

echo
echo "== 3. Minimal compile test with the build's actual flag set =="
tmpdir=$(mktemp -d)
cat > "$tmpdir/t.cpp" <<'EOF'
#include <cv_bridge/cv_bridge.hpp>
#include <sensor_msgs/msg/image.hpp>
#include <opencv2/core.hpp>
int main(){return 0;}
EOF
g++ -std=gnu++20 \
    -isystem /opt/ros/humble/include/sensor_msgs \
    -isystem /opt/ros/humble/include/cv_bridge \
    -isystem /usr/include/opencv4 \
    -c "$tmpdir/t.cpp" -o "$tmpdir/t.o" 2>&1 | head -15
if [ -f "$tmpdir/t.o" ]; then
    echo "OK: all includes resolve. Build should now pass."
else
    echo "STILL BROKEN - the missing headers above show what else needs a compat symlink."
fi
rm -rf "$tmpdir"

echo
echo "== 4. Rebuild the previously failing packages =="
cd ~/ros_ws || exit 0
colcon build --packages-select micron_driver_ros ping360_sonar gui_bluerov

echo
echo "Done. If all green, run a full build with:  colcon build  (in ~/ros_ws)"