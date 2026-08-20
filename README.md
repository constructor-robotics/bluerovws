# BlueROV2 Workspace ROS2

This is a ROS2 (Humble) workspace for the BlueROV2 and works with Docker + devcontainer.
It supports VSCode (Dev Containers: "Reopen in Container") and CLion (devcontainer attach).
On Linux the GUI display needs to be addressed in docker-compose.

Steps to do (fresh clone):
1. Initialize the submodules: `git submodule update --init --recursive`
2. Launch the devcontainer. The first start builds the image and installs the
   workspace dependencies automatically (rosdep install).
3. Compile the ROS2 workspace: `cd ~/ros_ws && colcon build`
4. The packages in src/ are git submodules and live in their own repositories
   (see src/README.md). Update them inside the submodule first, then bump the
   pointer in bluerovws.

# Network 
Base Station Config Linux
1. set static IP 
2. sudo sysctl -w net.ipv4.ip_forward=1 (should stay)
3. sudo iptables -t nat -A POSTROUTING -o $EXT -j MASQUERADE
4. sudo iptables -A FORWARD -i $EXT -o $INT -m state --state RELATED,ESTABLISHED -j ACCEPT
5. sudo iptables -A FORWARD -i $INT -o $EXT -j ACCEPT
6. sudo netfilter-persistent save 
7. sudo resolvectl dns eth0 1.1.1.1 (forward dns to find ip addresses on PI)

MACOS:
1. sudo nano /etc/pf.conf
2. Add something like this at the top or under nat-anchor if it exists: nat on en8 from en7:network to any -> (en8)
3. en8 is outside, and en7 is to PI
3. sudo sysctl -w net.inet.ip.forwarding=1
4. Permanent: sudo sh -c 'echo "net.inet.ip.forwarding=1" >> /etc/sysctl.conf'
5. sudo pfctl -f /etc/pf.conf
6. sudo pfctl -e   




foxglove integration: Located at [BlueROVView.json](config/BlueROVView.json)