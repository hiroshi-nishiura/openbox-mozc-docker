#!/bin/bash

# you can change password and/or geometry size to you want.

xvnc='x11vnc -passwd ubuntu -env FD_GEOM=1600x900 -env FD_PROG=openbox-session -create'

export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

if [ $1 ]; then
    if [ $1 == xvnc ]; then
	exec $xvnc
    elif [ $1 == novnc ]; then
	$xvnc -bg &
	exec ~/noVNC/utils/launch.sh --listen 5901 --vnc localhost:5900 --ssl-only
    fi
else
    exec bash
fi
