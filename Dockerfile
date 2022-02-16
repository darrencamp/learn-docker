FROM ubuntu:focal as linux-dev-base
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y tzdata

RUN apt-get install -y --no-install-recommends \
                    sudo \
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
WORKDIR ${BUILD_FOLDER}



