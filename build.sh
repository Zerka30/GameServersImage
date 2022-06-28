#! /bin/bash

workdir=`pwd`

# Build base image
cd ${workdir}/base/debian11
docker build -t scouthosting/base:bullseye .

# Build steamcmd image
cd ${workdir}/steamcmd
docker build -t scouthosting/steamcmd .

# Build game server image

cd ${workdir}/minecraft
docker build -t scouthosting/minecraft .

cd ${workdir}/csgo
docker build -t scouthosting/csgo .

cd ${workdir}/rust
docker build -t scouthosting/rust .