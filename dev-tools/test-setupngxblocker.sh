#!/bin/bash
# Travis CI Generating and Building for the Nginx Ultimate Bad Bot Blocker (using non standard folder locations)
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

##############################################################################                                                                
#       _  __     _                                                          #
#      / |/ /__ _(_)__ __ __                                                 #
#     /    / _ `/ / _ \\ \ /                                                 #
#    /_/|_/\_, /_/_//_/_\_\                                                  #
#       __/___/      __   ___       __     ___  __         __                #
#      / _ )___ ____/ /  / _ )___  / /_   / _ )/ /__  ____/ /_____ ____      #
#     / _  / _ `/ _  /  / _  / _ \/ __/  / _  / / _ \/ __/  '_/ -_) __/      #
#    /____/\_,_/\_,_/  /____/\___/\__/  /____/_/\___/\__/_/\_\\__/_/         #
#                                                                            #
##############################################################################                                                                

# ------------------------------------------------------------------------------
# MIT License
# ------------------------------------------------------------------------------
# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza
# ------------------------------------------------------------------------------
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# ------------------------------------------------------------------------------
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# ------------------------------------------------------------------------------
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------

export TERM=xterm

# ------------------------
# Set Terminal Font Colors
# ------------------------

bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
defaultcolor=$(tput setaf default)

# ---------
# FUNCTIONS
# ---------

setup_ubuntu_1804 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/ubuntu18.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/ubuntu18.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/ubuntu18.conf.modified
}

setup_ubuntu_1804MI () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/ubuntu18.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/ubuntu18.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/ubuntu18.conf.modified
}

setup_ubuntu_1804MI2 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/ubuntu18.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/ubuntu18.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/ubuntu18.conf.modified
}

setup_ubuntu_1804MI3 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/ubuntu18-hashbucket.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/ubuntu18.conf.modified.hashbucket 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/ubuntu18.conf.modified.hashbucket
sudo cat /etc/nginx/conf.d/botblocker-nginx-settings.conf > /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/botblocker-nginx-settings.conf
}

setup_ubuntu_1604 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/ubuntu16.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/ubuntu16.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/ubuntu16.conf.modified
}

setup_ubuntu_1604MI () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/ubuntu16.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/ubuntu16.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/ubuntu16.conf.modified
}

setup_ubuntu_1604MI2 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/ubuntu16.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/ubuntu16.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/ubuntu16.conf.modified
}

setup_arch () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/arch.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/arch.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/arch.conf.modified
}

setup_archMI () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/arch.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/arch.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/arch.conf.modified
}

setup_archMI2 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/arch.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/arch.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/arch.conf.modified
}

setup_centos () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/centos.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/centos.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/centos.conf.modified
}

setup_centosMI () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/centos.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/centos.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/centos.conf.modified
}

setup_centosMI2 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/centos.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/centos.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/centos.conf.modified
}

setup_fedora () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/fedora.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/fedora.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/fedora.conf.modified
}

setup_fedoraMI () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/fedora.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/fedora.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/fedora.conf.modified
}

setup_fedoraMI2 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/fedora.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/fedora.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/fedora.conf.modified
}

setup_opensuse () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/opensuse.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/opensuse.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/opensuse.conf.modified
}

setup_opensuseMI () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/opensuse.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/opensuse.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/opensuse.conf.modified
}

setup_opensuseMI2 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/opensuse.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/opensuse.conf.modified 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/opensuse.conf.modified
}

setup_debian8 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/debian-8-jessie.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/debian-8-jessie.conf.modified
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/original/debian-8-jessie.conf.modified
}

setup_debian8MI () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/debian-8-jessie.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/debian-8-jessie.conf.modified
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/modified/debian-8-jessie.conf.modified
}

setup_debian8MI2 () {
sudo cp /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/debian-8-jessie-hashbucket.conf /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/debian-8-jessie.modified.hashbucket 
sudo bash /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/setup-ngxblocker -x -m /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/debian-8-jessie.modified.hashbucket
sudo cat /etc/nginx/conf.d/botblocker-nginx-settings.conf > /home/runner/work/nginx-ultimate-bad-bot-blocker/nginx-ultimate-bad-bot-blocker/dev-tools/setup-ngxblocker/commented/botblocker-nginx-settings-debian-jessie-8.conf
}

# -----------------
# Trigger Functions
# -----------------

setup_ubuntu_1804
setup_ubuntu_1804MI
setup_ubuntu_1804MI2
setup_ubuntu_1804MI3
setup_ubuntu_1604
setup_ubuntu_1604MI
setup_ubuntu_1604MI2
setup_arch
setup_archMI
setup_archMI2
setup_centos
setup_centosMI
setup_centosMI2
setup_fedora
setup_fedoraMI
setup_fedoraMI2
setup_opensuse
setup_opensuseMI
setup_opensuseMI2
setup_debian8
setup_debian8MI
setup_debian8MI2

# ----------------------
# Exit With Error Number
# ----------------------

exit ${?}

# ------------------------------------------------------------------------------
# MIT License
# ------------------------------------------------------------------------------
# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza
# ------------------------------------------------------------------------------
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# ------------------------------------------------------------------------------
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# ------------------------------------------------------------------------------
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------
