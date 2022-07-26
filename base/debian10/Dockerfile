FROM debian:buster-slim

LABEL maintainer="contact@zerka.dev"
ARG TZ="Europe/Paris"

RUN apt-get update && apt-get dist-upgrade -y \
    && apt-get install -y \
    unzip \
    curl \
    wget \
    nano \
    software-properties-common \
    apt-transport-https \
    && apt-get clean -y \
    && echo "$TZ" > /etc/timezone \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime