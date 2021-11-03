#!/bin/bash

set -e

prefix=

if [ ! -z $1 ] && [ $1 = "in_chroot" ]
then
    prefix="arch-chroot /mnt "
fi

install_command="${prefix}pacman -Syu --needed --noconfirm"

re="[yY]"
if [[ $install_pipewire_audio_server =~ $re ]]
then
    $install_command pipewire pipewire-pulse pipewire-alsa alsa-utils easyeffects xdg-desktop-portal-gtk gst-plugin-pipewire helvum lib32-pipewire
else
    $install_command pulseaudio pulseaudio-alsa alsa-utils pavucontrol pulseaudio-equalizer-ladspa
fi

