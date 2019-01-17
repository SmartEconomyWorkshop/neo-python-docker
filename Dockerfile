FROM ubuntu:bionic
SHELL ["/bin/bash", "-c"]
WORKDIR /app
RUN apt update
RUN apt install -y -f libleveldb-dev python3 python3-dev python3-pip libleveldb-dev libssl-dev g++
RUN rm /var/lib/apt/lists/* -fr
COPY neo-python/ ./
COPY ./private.conf ./

RUN ["/usr/bin/pip3", "install", "wheel", "-e", "."]
RUN ["mkdir", "-p", "data"]

ENV DEBIAN_FRONTEND noninteractive

CMD ["np-prompt", "--config", "private.conf", "--datadir", "/app/data"]
