# docker build -t sglang:latest -f sglang/Dockerfile .

# FROM nvcr.io/nvidia/pytorch:25.02-py3
# FROM nvcr.io/nvidia/cuda:12.8.0-cudnn-devel-ubuntu22.04
FROM nvidia/cuda:12.8.0-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install curl -y

# --- only patch locally ---
ENV https_proxy=http://host.lima.internal:10800 http_proxy=http://host.lima.internal:10800

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
RUN micromamba install bash-completion -y
RUN micromamba install git openssh -y
RUN micromamba install clang-tools -y

# get clang headers from `clang` from conda
RUN CLANGD_VERSION=$(clangd --version | grep -Po '(?<=clangd version )[^.]+') && \
  micromamba install --download-only --no-deps clang-$CLANGD_VERSION && \
  cp -r $CONDA_PREFIX/../../pkgs/clang-$CLANGD_VERSION-*/lib/clang $CONDA_PREFIX/lib/

# TODO: keep more than one cn mirrors
# optional
RUN pip config set global.index-url 'https://mirrors.aliyun.com/pypi/simple/'

# TODO: support building `sgl-kernel`

RUN --mount=type=cache,target=/root/.cache/pip \
  pip install sglang[srt]

WORKDIR /

# essential tools
RUN micromamba install fd-find ripgrep

# TODO: oh-my-bash
# RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# --- only patch locally ---
RUN unset http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY
RUN echo "unset http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY" >>~/.bashrc
