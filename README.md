# BlueROV2 Workspace ROS2

This is a workspace to be working with Docker and Mac. Making it work on Linux should be straight forward.
Difference to Linux: The display of GUI needs to be addressed in docker-compose.
Additionally, this is designed to work with CLion devcontainer. Not designed for VSCode

Steps to do:
1. download the packages in src. to be compiled. the folders are out of this git reposetory. Therefore, they need to be updated independently, if you want to push your changes there.
2. Launch devcontainer.
3. Compile the ros2 ws in ~/ros_ws





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
7. sudo pfctl -n -f /etc/pf.conf












