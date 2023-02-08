# docker build -t clangdev:latest -f clangdev/Dockerfile --no-cache .
# docker build -t clangdev:latest -f clangdev/Dockerfile .

# FROM continuumio/miniconda3
# FROM condaforge/miniforge3
# FROM condaforge/mambaforge
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# install basic tools
RUN apt update
RUN apt install wget -y
RUN apt install sudo -y

# clang-10
RUN apt install -y --no-install-recommends clang
RUN apt install -y --no-install-recommends gcc g++

# install docker
WORKDIR /opt
RUN wget --progress=bar:force:noscroll https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz
RUN tar xf docker-20.10.9.tgz && rm -f docker-20.10.9.tgz
RUN echo "export PATH=\$PATH:/opt/docker" >>~/.bashrc
ENV PATH="/opt/docker:${PATH}"
WORKDIR /

# install Mambaforge
ENV PATH="/opt/conda/bin:${PATH}"
RUN wget --progress=bar:force:noscroll \
    https://github.com/conda-forge/miniforge/releases/download/22.9.0-3/Mambaforge-Linux-x86_64.sh \
    && bash Mambaforge-Linux-x86_64.sh -b -s -p /opt/conda \
    && rm -f Mambaforge-Linux-x86_64.sh
RUN conda init bash

# use conda-forge
RUN conda config --add channels conda-forge
RUN conda config --set channel_priority strict

# create new env
RUN conda create -n pyenv python=3.8 -y

RUN sed -e '/[ -z "$PS1" ] && return/s/^/#/g' -i ~/.bashrc
# set default conda env
RUN echo "export PROMPT_DIRTRIM=1" >> ~/.bashrc
RUN echo "conda activate pyenv" >> ~/.bashrc

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# install tools
# RUN mamba install clang clang-tools gcc gxx -y
# RUN mamba install binutils -y
# RUN mamba install sysroot_linux-64==2.17 -y

RUN mamba install cmake ninja -y
RUN mamba install bash-completion openssh curl -y
RUN mamba install git -y
RUN mamba install lld -y

# mamba install mlir libcxx
# RUN mamba install glog boost protobuf -y
