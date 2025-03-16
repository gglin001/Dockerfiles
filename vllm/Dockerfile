# docker build -t vllm:latest -f vllm/Dockerfile .

# FROM nvcr.io/nvidia/pytorch:25.02-py3
FROM nvidia/cuda:12.8.0-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# micromamba
RUN curl -LO micro.mamba.pm/install.sh
RUN bash install.sh
RUN rm -f install.sh

RUN sed -e '/[ -z "$PS1" ] && return/s/^/#/g' -i ~/.bashrc
# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]
RUN micromamba config append channels conda-forge
# TODO: python=3.10 or python=3.12 ?
RUN micromamba create -n pyenv python=3.12 -y

# set default env
RUN echo "micromamba activate pyenv" >> ~/.bashrc

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# micromamba
RUN micromamba install clang-tools -y

# get clang headers from `clang` from conda
RUN CLANGD_VERSION=$(clangd --version | grep -Po '(?<=clangd version )[^.]+') && \
  micromamba install --download-only --no-deps clang-$CLANGD_VERSION && \
  cp -r $CONDA_PREFIX/../../pkgs/clang-$CLANGD_VERSION-*/lib/clang $CONDA_PREFIX/lib/

# TODO: deal vllm depdency
