#!/bin/bash

# Get Type of Server from env variable
# Type can be : vanilla, bukkit, spigot, paper
# If not set, default to vanilla
type=${TYPE:-vanilla}

# Get version
# If not set, default is latest
version=${VERSION:-1.19.1}

# Eula must be accepted
# If not set, default is false
eula=${EULA:-false}

if [ "$eula" == "false" ]; then
    echo "EULA must be accepted"
    exit 1
fi

echo "Installing $type server in $version ..."

# Let's download server.jar
if [ ! -f /data/server.jar ]; then
    curl https://cdn.scouthosting.net/minecraft/${type}/${version}.jar -o /data/server.jar
fi

# Write eula.txt to accept EULA
if [ ! -f /data/eula.txt ]; then
    echo "eula=${eula}" > /data/eula.txt
fi

cd /data/; java -Xmx1024M -Xms${MAX_MEMORY:-1024}M -jar server.jar nogui