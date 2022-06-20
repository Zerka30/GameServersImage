FROM ubuntu:20.04

LABEL maintainer="contact@zerka.dev"

ENV USER minecraft
ENV VERSION 1.18.1
ENV SERVERDIR "/data"

WORKDIR ${SERVERDIR}

EXPOSE 25565

VOLUME ["/data"]

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    sudo \
    gnupg-agent \
    software-properties-common \
    wget \
    openjdk-8-jre-headless \
    && useradd -m "${USER}"

ADD ./start.sh ./start.sh

RUN chmod +x ./start.sh

CMD ["./start.sh"]