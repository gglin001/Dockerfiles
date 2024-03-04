# docker build -t nix:latest -f nix/Dockerfile .

# FROM base:latest
FROM ubuntu:22.04
# TODO: use nixos/nix
# FROM nixos/nix:latest

ENV DEBIAN_FRONTEND=noninteractive

# install basic tools
RUN apt update
RUN apt install wget curl -y
RUN apt install xz-utils -y

SHELL ["bash", "-l", "-c"]

# https://nixos.org/download
RUN sh <(curl -L https://nixos.org/nix/install) --daemon --yes