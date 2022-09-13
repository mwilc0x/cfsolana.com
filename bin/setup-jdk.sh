#!/bin/bash

# # Dependencies for makepkg and JDK
pacman -Sy --noconfirm binutils wget pacman-contrib git unzip which

# # We need to set user other than root for makepkg
# # https://www.reddit.com/r/archlinux/comments/evarc8/how_to_run_makepkg_in_docker_container_yes_as/
pacman -S --needed --noconfirm sudo # Install sudo
# useradd builduser -m # Create the builduser
# passwd -d builduser # Delete the buildusers password
# printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers # Allow the builduser passwordless sudo

sudo pacman -Syyu --noconfirm
sudo pacman-db-upgrade
sudo pacman -S --noconfirm jdk11-openjdk
