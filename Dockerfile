# https://hub.docker.com/_/ubuntu/
# FROM ros:humble

# RUN apt-get update 
# RUN apt-get install -y \
# 	ros-humble-rviz2

FROM ubuntu:22.04

ENV TERM="xterm-256color"
ENV GIT_DISCOVERY_ACROSS_FILESYSTEM=0

# TODO: improve order of commands, incorporate best prcatices for apt

RUN apt-get update
RUN bash -c "yes | unminimize"

# RUN echo -en '\nnameserver 8.8.8.8\nnameserver 8.8.4.4' >> /etc/resolv.conf
# RUN sed -ci '1s/^/nameserver 8.8.4.4\n/' /etc/resolv.conf


RUN apt-get install -y --fix-missing \
	curl wget git gcc g++ clang make valgrind zip iputils-ping \
	man-db \
	cmake \
    openssh-server \
	vim \
	ranger \
	software-properties-common \
	sudo \
	locales

RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV TZ Europe/Prague
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# setup ros humble
RUN apt-get update
# RUN add-apt-repository universe
# RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
# RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
# RUN apt-get update && apt-get upgrade -y
# RUN apt-get install -y ros-humble-desktop


RUN useradd --create-home --shell /bin/bash nvidia
RUN usermod -aG sudo nvidia
USER nvidia
RUN passwd
WORKDIR /home/nvidia
# ENV HOSTNAME tx2-ros2-docker
# RUN echo $(grep $(hostname) /etc/hosts | cut -f1) tx2-ros2-docker >> /etc/hosts && install-software




# RUN apt-get install -y \
# 	ros-humble-rviz2