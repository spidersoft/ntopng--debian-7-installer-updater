#!/bin/sh
#
# Ntopng automatic Install And Update process for Debian 7 wheezy 32 y 64 bits
# Version: 1.2
# License: GPLv3
# Author : Jose
# Credits: josecp300@gmail.com
# Date   : Jul 2014
echo "#### Installing/Updating Script for Ntopng SVN ####"
echo "#### Test on Debian wheezy 32 Minimal version ####"
echo "#### Spidersoft 2014 ####"

#==== Installing/Updating distro packages and dependencies ====
echo "#### Installing/Updating System ####"
apt-get update
apt-get upgrade
apt-get install dh-autoreconf build-essential libpcap0.8-dev libxml2-dev libglib2.0 libglib2.0-dev geoip-bin libgeoip-dev geoip-database gnutls-bin libgnutls-dev redis-server subversion libpcap-dev libtool rrdtool autoconf libsqlite3-dev
#==== Downloading current SVN Version ====
        echo "#### CLONING SVN ####"
        cd /usr/local/src/
        svn co https://svn.ntop.org/svn/ntop/trunk/ntopng/
        cd ntopng
        echo "#### COMPILING AND INSTALLING ####"
        /usr/local/src/ntopng/autogen.sh
        cd  /usr/local/src/ntopng/
        ./configure
        make geoip
        make
        make install
        echo "#### BUILD AND INSTALL FINISH ####"
echo "Start on any interface ??(kill others ntopng) ******   1)Yes      2)No     3)Start on screen "

read n
case $n in
    1) killall ntopng ;  ntopng -i any ;;
    2) echo "Finish";;
# First Close any old Ntopng Screen on system
    3) screen -r ntop  -X quit ; screen -A -m -d -S ntop ntopng -i any |  echo "Start on Screen, type [ screen -r ntop ] for resume and CRTL+a and d later for exit from screen. Finish";;
    *) echo " Invalid option Only install. Finish";;
esac
