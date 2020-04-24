FROM ubuntu:18.04
MAINTAINER nishiura.hiroshi@gmail.com

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git tzdata && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apt-get install -y openbox obmenu obconf tint2 xfce4-terminal x11vnc xvfb x11-xserver-utils net-tools firefox emacs wget curl htop scrot python-numpy sudo language-pack-ja-base language-pack-ja fonts-takao fcitx-mozc emacs-mozc fonts-inconsolata && apt-get upgrade -y

# Japanese environment
ENV LANG ja_JP.UTF-8
RUN locale-gen en_US.UTF-8
RUN locale-gen ja_JP.UTF-8

# ubuntu user to run mozc_server
RUN useradd -G sudo -m -s /bin/bash ubuntu && echo 'ubuntu:ubuntu' | chpasswd

WORKDIR /home/ubuntu
RUN mkdir -p .config/openbox
ADD autostart .config/openbox/autostart
ADD rc.xml .config/openbox/rc.xml

# Emacs
ADD .emacs .emacs
#RUN mkdir .emacs.d
#ADD setup.el .emacs.d/setup.el
#RUN su - ubuntu -c 'emacs --script .emacs.d/setup.el'

# Startup
ADD startup.sh startup.sh
ADD .Xresources .Xresources
ADD .x11vncrc .x11vncrc
RUN chown -R ubuntu.ubuntu * .*

USER ubuntu
ENTRYPOINT ["bash","./startup.sh"]
