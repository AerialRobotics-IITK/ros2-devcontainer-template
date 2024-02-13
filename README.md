## VSCode Devcontainer template with ROS2 Humble + Gazebo Garden
This is .devcontainer template with all dependencies for ArduPilot pre-installed making it easier to carry out development using ROS2 and ArduPilot SITL. <br> Using Devcontainers requires installation of the corresponding VSCode extensions and necessary dependencies, you may check [here](https://code.visualstudio.com/docs/devcontainers/devcontainer-cli) for instructions

### Instructions
#### Directory Structure
```
workspace_folder
├── cache
│   └── humble
│       ├── build
│       ├── install
│       └── log
└── src
│   ├── <your-packages>
│   ├──     ...

```

#### Usage
1. Create and organize your ROS2 workspace in the above described manner.
2. ``git clone git@github.com:AerialRobotics-IITK/ros2-devcontainer-template.git <workspace-folder>/src/.devcontainer/``
3. ``code <workspace-folder>/src``
4. Reopen folder in Container : VSCode will detect the Dockerfile under .devcontainer and start building i

#### Integrating other apt packages in Docker Image
In ``Dockerfile``, append package names that you'd like to have pre-installed in the image [here](https://github.com/pulak-gautam/ardupilot_gz-devcontainer/blob/master/Dockerfile#L66C1-L69C5)

### Details  
  - ``cache`` including build, log and install is locally stored : reduces building time for previously built packages
  - off the shelf support for GUI : no extra commands are necessary to be run for enabling GUI support
