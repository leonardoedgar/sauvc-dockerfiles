FROM ros:melodic-ros-core-bionic
MAINTAINER Leonardo Edgar

# Install core linux tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils lsb-release sudo unzip wget ssh vim curl\
    && rm -rf /var/lib/apt/lists/* 

# Install python
RUN apt-get update && \
    apt-get install -y ipython \
    python-dev python-numpy python-pip \
    python-scipy python-pytest python-opencv \
    python-serial python-pytest-mock python-ipdb

# Install python-catkin-tools
RUN apt-get update && apt-get install -y python-catkin-tools\
    && rm -rf /var/lib/apt/lists/*

# User and permissions
ARG user=leonardo
ARG group=leonardo
ARG uid=1000
ARG gid=1000
ARG home=/home/${user}
RUN mkdir -p /etc/sudoers.d \
    && groupadd -g ${gid} ${group} \
    && useradd -d ${home} -u ${uid} -g ${gid} -m -s /bin/bash ${user} \
    && echo "${user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/sudoers_${user}
USER ${user}
RUN sudo usermod -a -G video ${user}
RUN sudo usermod -a -G dialout ${user}

WORKDIR ${home}

# Setup catkin workspace
RUN mkdir catkin_ws/src -p
COPY --chown=leonardo catkin_ws/src/sauvc				    catkin_ws/src/sauvc
COPY --chown=leonardo catkin_ws/src/rosserial				catkin_ws/src/rosserial
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash; cd catkin_ws/src; catkin_init_workspace; cd ..; catkin_make"

# Update .bashrc for bash interactive mode
RUN echo "source /home/leonardo/catkin_ws/devel/setup.bash\nPATH=$HOME/.local/bin:$PATH" >> /home/leonardo/.bashrc

# Update entrypoint for commands
COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN bash -c "sudo chmod +x /ros_entrypoint.sh"
RUN sudo sed --in-place --expression \
    '$isource "/home/leonardo/catkin_ws/devel/setup.bash"' \
    /ros_entrypoint.sh

# Add script to run serial node
COPY run_serial_node.sh /run_serial_node.sh
RUN bash -c "sudo chmod +x /run_serial_node.sh"
