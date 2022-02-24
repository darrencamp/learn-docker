# syntax=docker/dockerfile:1.2

FROM ubuntu:focal as linux-dev-base
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y tzdata

RUN apt-get install -y --no-install-recommends \
                    sudo \
                    net-tools \
                    openssh-client \
                    git \
                    curl \
                    unzip \
                    tar \
                    ca-certificates \
                    wget \
                    && \
    apt-get autoclean && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 1000 builder \
    && useradd --uid 1000 --gid 1000 -m -p builder builder \
    && echo builder ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/builder \
    && chmod 0440 /etc/sudoers.d/builder

ENV BUILD_FOLDER /build

USER builder
WORKDIR /home/builder

RUN eval `ssh-agent`
RUN mkdir ~/.ssh 
#&& ssh-keyscan -t rsa -p 7999 aumel-constash.leicabio.com >> ~/.ssh/known_hosts

FROM linux-dev-base as FirmwareSimulator
RUN sudo apt-get update -y && \
    sudo apt-get install -y python2.7
 
# ideally use ssh forwarding and/or secrets but couldn't get that to work
#RUN --mount=type=ssh git clone ssh://git@aumel-constash.leicabio.com:7999/speed/firmwaresimulator.git
#so instead use build time parameters to pass in a ssh key
ARG SSH_PRIVATE_KEY
RUN echo "${SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa
RUN echo "${SSH_PUB_KEY}" > ~/.ssh/id_rsa.pub
RUN chmod 0600 ~/.ssh/id_rsa && chmod 0600 ~/.ssh/id_rsa.pub
RUN eval `ssh-agent -s` && ssh-add ~/.ssh/id_rsa

#RUN git clone ssh://git@aumel-constash.leicabio.com:7999/speed/firmwaresimulator.git


