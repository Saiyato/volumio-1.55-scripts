#!/bin/sh
# Spop installation script for OSMC
# Add Spotify repository
echo "Setting up source list..."
wget -q -O - http://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
echo "deb http://apt.mopidy.com/ stable main contrib non-free\ndeb-src http://apt.mopidy.com/ stable main contrib non-free" | sudo tee /etc/apt/sources.list.d/mopidy.list

# Update repository and install
echo "Updating repositories and installing dependencies..."
apt-get update
apt-get -y install cmake make git telnet build-essential libjson-glib-dev libao-dev libdbus-glib-1-dev libnotify-dev libsoup2.4-dev libsox-dev libspotify-dev

# Create the directory to build into and clone the git
echo "Fetching spop-client from github..."
mkdir -p /home/osmc/gitrepos
cd /home/osmc/gitrepos
git clone git://github.com/Schnouki/spop.git

# Copy the configuration into a new config
echo "Preparing to compile and build..."
#mkdir -p ~/.config/spop

# The default config file contains too many variables, causing volumio to be unable to set it up
#cp spop/spopd.conf.sample /etc/spopd.conf
echo "#" | sudo tee /etc/spopd.conf
chmod 777 /etc/spopd.conf

# Try to build spop
cd /home/osmc/gitrepos/spop
cmake -DCMAKE_INSTALL_PREFIX=/usr
make
make install

# Make sure you edit the /etc/spopd.conf file, username/password and remove any unused functionality. Otherwise spop will not start correctly