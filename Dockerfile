FROM ubuntu:16.04
MAINTAINER nishiura.hiroshi@gmail.com

# Desktop
RUN apt-get update
RUN apt-get install -y openbox obmenu obconf tint2 xfce4-terminal x11vnc xvfb x11-xserver-utils

# Tools
RUN apt-get install -y net-tools firefox emacs git wget curl htop scrot

# Runtime
RUN apt-get install -y python-numpy

# Japanese environment
RUN apt-get install -y language-pack-ja-base language-pack-ja fonts-takao fcitx-mozc
RUN apt install -y emacs-mozc fonts-inconsolata
ENV LANG ja_JP.UTF-8
RUN locale-gen en_US.UTF-8
RUN locale-gen ja_JP.UTF-8

# TimeZone
RUN echo "tzdata tzdata/Areas select Asia" > /tmp/tzdata
RUN echo "tzdata tzdata/Zones/Asia select Tokyo" >> /tmp/tzdata
RUN debconf-set-selections /tmp/tzdata
RUN rm /etc/timezone
RUN rm /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

# ubuntu user to run mozc_server
RUN apt-get install -y sudo
RUN useradd -G sudo -m -s /bin/bash ubuntu && echo 'ubuntu:ubuntu' | chpasswd

WORKDIR /home/ubuntu
RUN mkdir -p .config/openbox
ADD autostart .config/openbox/autostart
ADD rc.xml .config/openbox/rc.xml

# noVNC
RUN git clone https://github.com/novnc/noVNC.git
RUN git clone https://github.com/novnc/websockify noVNC/utils/websockify
RUN openssl req -new -x509 -days 3650 -nodes -out noVNC/self.pem -keyout noVNC/self.pem -subj "/"

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

# default argument for startup
#CMD ["xvnc"]
