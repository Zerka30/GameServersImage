#! /bin/bash

workdir=`pwd`

# Login to registry
docker login

# Build base image
cd ${workdir}/base/debian11
docker build -t scouthosting/base:bullseye .
docker tag scouthosting/base:bullseye registry.scouthosting.net/base:bullseye
docker push registry.scouthosting.net/base:bullseye

# Build steamcmd image
cd ${workdir}/steamcmd
docker build -t scouthosting/steamcmd .
docker tag scouthosting/steamcmd registry.scouthosting.net/steamcmd:latest
docker push registry.scouthosting.net/steamcmd:latest

# Build game server image

cd ${workdir}/minecraft
docker build -t scouthosting/minecraft .
docker tag scouthosting/minecraft registry.scouthosting.net/minecraft:latest
docker push registry.scouthosting.net/minecraft:latest

cd ${workdir}/csgo
docker build -t scouthosting/csgo .
docker tag scouthosting/csgo registry.scouthosting.net/csgo:latest
docker push registry.scouthosting.net/csgo:latest

cd ${workdir}/rust
docker build -t scouthosting/rust .
docker tag scouthosting/rust registry.scouthosting.net/rust:latest
docker push registry.scouthosting.net/rust:latest