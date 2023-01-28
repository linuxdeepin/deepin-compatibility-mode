FROM debian:buster-slim

RUN apt update && \
  apt install -y ca-certificates gnupg && \
  rm -rf /var/lib/apt/lists/*

COPY sources.list /etc/apt/sources.list

COPY packages.list /etc/deepin/compatibility-mode/packages.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 425956BB3E31DF51 &&\
  apt update && \
  DEBIAN_FRONTEND=noninteractive xargs apt install -y < /etc/deepin/compatibility-mode/packages.list && \
  rm -rf /usr/share/fonts/ && \
  rm -rf /var/lib/apt/lists/*
