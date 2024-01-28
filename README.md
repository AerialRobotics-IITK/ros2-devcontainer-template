## ardupilot_gz devcontainer template

### Instructions

1. 
    ```
    #go into your ros2 workspace
    mkdir -p ~/ros2_ws/src && cd ~/ros2_ws
    ```
2. 
    ```
    #clone the repo into .devcontainer folder at root of workspace
    mkdir .devcontainer && git clone git@github.com:pulak-gautam/ardupilot_gz-devcontainer.git .
    ```
3. Open VSCode and run "Reopen in Devcontainer"


### Details
- your workspace will be mounted over ``/workspaces``
- ardupilot_gz and SITL related packages are in ``/workspaces/ardupilot_ws``
