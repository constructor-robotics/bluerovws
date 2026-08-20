FROM ubuntu:22.04



ARG USERNAME=bluerovuser
ARG USER_UID=1001
ARG USER_GID=$USER_UID
#ARG DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble
#ARG DEBIAN_FRONTEND=noninteractive

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to istall software after connecting.
    && apt update \
    && apt install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME


USER $USERNAME



WORKDIR /home/$USERNAME/install_ws

#ROS
RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt update && sudo DEBIAN_FRONTEND=noninteractive sudo apt install -y locales
RUN sudo DEBIAN_FRONTEND=noninteractive sudo locale-gen de_DE de_DE.UTF-8
RUN sudo DEBIAN_FRONTEND=noninteractive sudo update-locale LC_ALL=de_DE.UTF-8 LANG=de_DE.UTF-8
ENV LANG=de_DE.UTF-8 LC_ALL=de_DE.UTF-8
RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt-get install -y tzdata
RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt install -y libboost-all-dev bash-completion




RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt install software-properties-common -y
RUN sudo DEBIAN_FRONTEND=noninteractive sudo add-apt-repository universe
RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt update && sudo apt install curl -y
RUN sudo DEBIAN_FRONTEND=noninteractive sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt update
RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt install ros-dev-tools -y
RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt upgrade -y

RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt install ros-$ROS_DISTRO-desktop -y
# foxglove as alternative to RVIZ. Since it has a better visualization and can be used outside of Docker natively on Mac/Linux
RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt install ros-$ROS_DISTRO-foxglove-bridge -y
#RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt install ros-$ROS_DISTRO-open3d-conversions -y



# custom stuff
RUN #sudo apt-get update && sudo apt-get -y install python3 python3-pip
RUN sudo DEBIAN_FRONTEND=noninteractive sudo apt-get update && sudo apt-get -y install python3-pip
RUN sudo apt install nlohmann-json3-dev -y
RUN sudo apt install libqt5gamepad5-dev -y
RUN sudo apt install libcgal-dev -y
RUN sudo apt install unzip nano net-tools nmap inetutils-ping -y
RUN sudo apt install openssh-client -y

#COPY otherPackages/PX4-Autopilot/Tools/setup/ubuntu.sh /home/$USERNAME/install_ws
#WORKDIR /home/$USERNAME/install_ws
#RUN mkdir -p -m 0600 ~/.ssh
#RUN sudo ssh-keyscan github.com >> ~/.ssh/known_hosts
RUN mkdir /home/$USERNAME/volumeROS
RUN mkdir /home/$USERNAME/ros_ws

RUN sudo DEBIAN_FRONTEND=noninteractive sudo rosdep init && sudo rosdep update --rosdistro $ROS_DISTRO # buildkit


WORKDIR /home/$USERNAME/

WORKDIR /home/$USERNAME/
#ENV ROS_DISTRO=humble
ENV SHELL=/bin/bash


RUN echo 'if [ -f /etc/bash_completion ]; then . /etc/bash_completion; fi' >> ~/.bashrc

RUN echo "PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]$\[\033[0m\] ' "  >> ~/.bashrc
RUN #echo "source activate base">> ~/.bashrc
RUN #echo "COLCON_DEFAULTS_FILE=/home/$USERNAME/ros_ws/configFiles/defaultColconSettings.yaml">> ~/.bashrc
RUN echo "source /opt/ros/humble/setup.bash">> ~/.bashrc
RUN echo "[ -f /home/$USERNAME/ros_ws/install/setup.bash ] && source /home/$USERNAME/ros_ws/install/setup.bash">> ~/.bashrc
RUN echo "export ROS_DOMAIN_ID=161">> ~/.bashrc
# profile because of clion connection, so that you can compile ROS inside the IDE
RUN echo "source /opt/ros/humble/setup.bash">> ~/.profile
RUN echo "[ -f /home/$USERNAME/ros_ws/install/setup.bash ] && source /home/$USERNAME/ros_ws/install/setup.bash">> ~/.profile
RUN echo "export ROS_DOMAIN_ID=161">> ~/.profile


# COPY docker-entrypoint.sh /
# RUN chmod +x /docker-entrypoint.sh
# ENTRYPOINT [ "/docker-entrypoint.sh" ]

 CMD ["/bin/bash"]
#CMD ["sleep", "infinity"]
