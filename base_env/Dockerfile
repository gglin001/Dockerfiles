# docker build -t base_env:20.04 -f base_env/Dockerfile --no-cache .
# docker build -t base_env:20.04 -f base_env/Dockerfile .
# docker tag base_env:20.04 base_env:latest

# FROM continuumio/miniconda3
# FROM condaforge/miniforge3
# FROM condaforge/mambaforge
# FROM ubuntu:20.04
FROM buildpack-deps:focal

ENV DEBIAN_FRONTEND=noninteractive

# install basic tools
RUN apt update
RUN apt install wget curl -y
RUN apt install sudo -y
RUN apt install make -y

# compiler
RUN apt install -y --no-install-recommends clang lld
RUN apt install -y --no-install-recommends gcc g++

# install docker
WORKDIR /opt
RUN wget --progress=bar:force:noscroll https://download.docker.com/linux/static/stable/$(uname -m)/docker-24.0.5.tgz -O docker.tgz
RUN tar xf docker.tgz && rm -f docker.tgz
RUN echo "export PATH=\$PATH:/opt/docker" >>~/.bashrc
ENV PATH="/opt/docker:${PATH}"
WORKDIR /

# micromamba
RUN curl -LO micro.mamba.pm/install.sh
RUN bash install.sh
RUN rm -f install.sh

RUN sed -e '/[ -z "$PS1" ] && return/s/^/#/g' -i ~/.bashrc
# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]
RUN micromamba config append channels conda-forge
RUN micromamba create -n pyenv python=3.12 -y

# set default env
RUN echo "export PROMPT_DIRTRIM=1" >> ~/.bashrc
RUN echo "alias conda=$HOME/micromamba/bin/micromamba" >> ~/.bashrc
RUN echo "alias mamba=$HOME/micromamba/bin/micromamba" >> ~/.bashrc
RUN echo "micromamba activate pyenv" >> ~/.bashrc

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# micromamba
RUN micromamba install cmake ninja -y
RUN micromamba install bash-completion -y
RUN micromamba install git -y
