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

# install Mambaforge
ENV PATH="/opt/conda/bin:${PATH}"
RUN wget --progress=bar:force:noscroll \
    https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh \
    && bash Mambaforge-Linux-x86_64.sh -b -p /opt/conda \
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
RUN mamba install bash-completion openssh curl -y

# install compiler
# will install sysroot_linux-64
RUN mamba install clang clang-tools gcc gxx cmake ninja -y

# install libs
# mamba install mlir libcxx
# RUN mamba install glog boost protobuf -y

# set env
# LD_LIBRARY_PATH
# RUN echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/opt/conda/envs/pyenv/lib" >> ~/.bashrc
# RUN echo "export LIBRARY_PATH=\$LIBRARY_PATH:/opt/conda/envs/pyenv/lib" >> ~/.bashrc
# ENV LD_LIBRARY_PATH="/opt/conda/lib:$LD_LIBRARY_PATH"
