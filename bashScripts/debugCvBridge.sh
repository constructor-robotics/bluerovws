#!/bin/bash
# Debug helper for the cv_bridge include issue in the bluerovws devcontainer.
# Run INSIDE the container (as bluerovuser) from anywhere:
#   bash bashScripts/debugCvBridge.sh
# Paste the full output.

set -u
echo "== 1. Header location =="
ls -la /opt/ros/humble/include/cv_bridge/
echo
dpkg -L ros-humble-cv-bridge 2>/dev/null | grep -E "cv_bridge.hpp|include/cv_bridge" | head
echo

echo "== 2. Compatibility symlink =="
ls -la /opt/ros/humble/include/cv_bridge/cv_bridge.hpp 2>&1
echo

echo "== 3. CMake compile flags for visualizationMicron (micron_driver_ros) =="
flags=~/ros_ws/build/micron_driver_ros/CMakeFiles/visualizationMicron.dir/flags.make
if [ -f "$flags" ]; then
    grep -E "CXX_DEFINES|CXX_INCLUDES|CXX_FLAGS" "$flags"
else
    echo "no flags.make yet (package not configured): $flags"
fi
echo

echo "== 4. Which cv_bridge did CMake resolve? =="
grep -i "cv_bridge" ~/ros_ws/build/micron_driver_ros/CMakeCache.txt 2>/dev/null | head
echo

echo "== 5. Installed package exports (include dirs) =="
grep -rE "INTERFACE_INCLUDE_DIRECTORIES|_IMPORT_PREFIX" /opt/ros/humble/share/cv_bridge/cmake/ 2>/dev/null | head
echo

echo "== 6. Environment prefix paths =="
echo "AMENT_PREFIX_PATH:"
echo "$AMENT_PREFIX_PATH" | tr ':' '\n' | sed 's/^/  /'
echo "CMAKE_PREFIX_PATH:"
echo "$CMAKE_PREFIX_PATH" | tr ':' '\n' | sed 's/^/  /'
echo

echo "== 7. Minimal compile tests =="
tmpdir=$(mktemp -d)
printf '#include <cv_bridge/cv_bridge.hpp>\nint main(){return 0;}\n' > "$tmpdir/t1.cpp"
printf '#include <opencv2/core.hpp>\nint main(){return 0;}\n' > "$tmpdir/t2.cpp"
g++ -std=c++17 -I/opt/ros/humble/include -c "$tmpdir/t1.cpp" -o /dev/null 2>&1 \
    && echo "OK: classic include works with -I/opt/ros/humble/include" \
    || echo "FAIL: classic include with -I/opt/ros/humble/include"
g++ -std=c++17 -isystem /opt/ros/humble/include -c "$tmpdir/t1.cpp" -o /dev/null 2>&1 \
    && echo "OK: classic include works with -isystem /opt/ros/humble/include" \
    || echo "FAIL: classic include with -isystem"
g++ -std=c++17 -I/opt/ros/humble/include -c "$tmpdir/t2.cpp" -o /dev/null 2>&1 \
    && echo "OK: opencv include works" \
    || echo "FAIL: opencv include"
rm -rf "$tmpdir"
echo

echo "== 8. Rebuild micron_driver_ros verbosely (shows the real g++ line) =="
cd ~/ros_ws || exit 0
colcon build --packages-select micron_driver_ros --event-handlers console_direct+ 2>&1 \
    | grep -E "g\+\+|c\+\+|fatal error|Could not find|CMake Error" | head -10
echo
echo "Done."