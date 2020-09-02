#!/bin/bash

set -e

path_to_iso=
path_to_sig=
device=

lsblk
read -e -p "Enter USB device (sda, sdb, sdX,...): " device
read -e -p "Enter path to the iso: " path_to_iso
read -e -p "Enter path to signature file: " path_to_sig
gpg $path_to_sig

sudo dd if=/dev/zero of=/dev/$device bs=4M count=1
sudo parted /dev/$device mklabel gpt
sudo sgdisk -Z /dev/$device
sudo sgdisk -n 0:0:0 /dev/$device
sudo dd if=$path_to_iso of=/dev/$device bs=4M && sync
udisksctl power-off -b /dev/$device
