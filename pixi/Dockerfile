# docker build -t pixi:latest -f pixi/Dockerfile .

# FROM ubuntu:24.04
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# install basic tools
RUN apt update
RUN apt install wget curl -y
RUN apt install xz-utils -y

SHELL ["bash", "-l", "-c"]

RUN curl -fsSL https://pixi.sh/install.sh | sh
