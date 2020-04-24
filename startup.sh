#!/bin/bash

# you can change password and/or geometry size to you want.

xvnc='x11vnc -passwd ubuntu -env FD_GEOM=1920x1080 -env FD_PROG=openbox-session -create'

export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

if [ $1 -a $1 = vnc ]; then
    exec $xvnc
else
    exec bash
fi
