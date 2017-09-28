export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

x11vnc -passwd ubuntu -env FD_GEOM=1280x800 -env FD_PROG=openbox-session -create
