FROM ubuntu:20.04

LABEL maintainer="contact@zerka.dev"
ARG TZ="Europe/Paris"

RUN apt-get update && apt-get dist-upgrade -y \
    && apt-get install -y \
    curl \
    wget \
    nano \
    unzip \
    sudo \
    apt-transport-https \
    software-properties-common \ 
    ca-certificates \
    gnupg-agent \
    && apt-get clean -y \
    && echo "$TZ" > /etc/timezone \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime