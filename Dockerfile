FROM osrf/ros:humble-desktop

# Add vscode user with same UID and GID as your host system
# (copied from https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user#_creating-a-nonroot-user)
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
# Switch from root to user
USER $USERNAME

# Add user to video group to allow access to webcam
RUN sudo usermod --append --groups video $USERNAME

# Update all packages
RUN sudo apt update && sudo apt upgrade -y

# Install Git
RUN sudo apt install -y git 

############################# Gazebo Fortress Install #####################################
# RUN sudo apt-get install -y lsb-release wget gnupg
# RUN sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg \
#     && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null \
#     && sudo apt-get update -y \
#     && sudo apt-get install -y ignition-fortress

# RUN sudo apt-get install ros-humble-ros-gz -y

############################# Gazebo Garden Install #######################################

RUN sudo apt-get install -y lsb-release wget gnupg
RUN sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null && \
    sudo apt-get update -y && \
    sudo apt-get install gz-garden -y
RUN sudo apt-get install ros-humble-ros-gzgarden -y

###########################################################################################
# Rosdep update
RUN rosdep update


############################# Additional Dependencies #########################################

# XRCE DDS
RUN cd / && sudo git clone --recurse-submodules https://github.com/ardupilot/Micro-XRCE-DDS-Gen.git && \
    cd Micro-XRCE-DDS-Gen && \
    sudo ./gradlew assemble
RUN echo "export PATH=$PATH:/Micro-XRCE-DDS-Gen/scripts" >> ~/.bashrc

RUN sudo apt install python3-pip -y && \
    python3 -m pip install pexpect && \
    python3 -m pip install future

# MAVProxy
RUN sudo apt-get install python3-dev python3-opencv python3-wxgtk4.0 python3-pip python3-matplotlib python3-lxml python3-pygame -y && \
    pip3 install PyYAML mavproxy --user && \
    echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc

RUN sudo apt-get install -y \
    vim
    ## append your packages here ##
    
################################# Source files ############################################
# Source the ROS setup file
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
