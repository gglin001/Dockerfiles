# docker build -t vllm:latest -f vllm/Dockerfile .

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

# deal vllm depdency
WORKDIR /opt/vllm_deps

WORKDIR /opt/vllm_deps/requirements
# https://github.com/vllm-project/vllm/blob/main/requirements
RUN curl -LO https://github.com/vllm-project/vllm/raw/refs/heads/main/requirements/build.txt
RUN curl -LO https://github.com/vllm-project/vllm/raw/refs/heads/main/requirements/common.txt
RUN curl -LO https://github.com/vllm-project/vllm/raw/refs/heads/main/requirements/cuda.txt
# dev.txt
RUN curl -LO https://github.com/vllm-project/vllm/raw/refs/heads/main/requirements/dev.txt
RUN curl -LO https://github.com/vllm-project/vllm/raw/refs/heads/main/requirements/lint.txt
RUN curl -LO https://github.com/vllm-project/vllm/raw/refs/heads/main/requirements/test.txt

# --- only patch locally ---
ENV https_proxy="" http_proxy=""

RUN --mount=type=cache,target=/root/.cache/pip \
  pip install -r build.txt
RUN --mount=type=cache,target=/root/.cache/pip \
  pip install -r cuda.txt
# dev.txt
RUN --mount=type=cache,target=/root/.cache/pip \
  pip install -r lint.txt
# test.txt
RUN ARCH=$(uname -m) && \
  if [ "$ARCH" = "arm64" ] || [ "$ARCH" = "aarch64" ]; then \
  # bitsandbytes requires x86, disable if building a test image on macos
  sed -i "s/^bitsandbytes=/# bitsandbytes=/" test.txt \
  && sed -i "s/^decord=/# decord=/" test.txt \
  # disable `nvidia-*` libs, TODO: fix it
  && sed -i "s/^nvidia-/# nvidia-/" test.txt \
  # sed -i "s/^nvidia-cudnn-cu12==9.1.0.70/nvidia-cudnn-cu12==9.8.0.87/" test.txt
  && sed -i "s/^runai-/# runai-/" test.txt \
  && sed -i "s/^triton=/# triton=/" test.txt ; fi
RUN --mount=type=cache,target=/root/.cache/pip \
  pip install -r test.txt

# --- only patch locally ---
ENV https_proxy=http://host.lima.internal:10800 http_proxy=http://host.lima.internal:10800

ARG FETCH_DEPS
WORKDIR /opt/vllm_deps
RUN if [ "$FETCH_DEPS" -eq "1" ]; then \
  git clone https://github.com/nvidia/cutlass.git \
  && git clone https://github.com/vllm-project/FlashMLA.git \
  &&  git clone https://github.com/vllm-project/flash-attention.git \
  # TODO: updates commits if needed or do it in container ?
  && pushd cutlass && git switch -d v3.8.0 && popd \
  && pushd FlashMLA && git switch -d 575f7724b9762f265bbee5889df9c7d630801845 && popd \
  && pushd flash-attention && git switch -d 9bfa9869829d8c593527eb34c5271d0090f7ccc9 && popd \
  && pushd FlashMLA && git submodule update --init --depth 1 && popd \
  && pushd flash-attention && git submodule update --init --depth 1 && popd ; fi

ARG PRE_COMMIT_INSTALL
WORKDIR /tmp/pre-commit_hook
# cache pre-commit hooks
RUN if [ "$FETCH_DEPS" -eq "1" ]; then \
  curl -LO https://github.com/vllm-project/vllm/raw/refs/heads/main/.pre-commit-config.yaml \
  && git init \
  && pre-commit install-hooks -c .pre-commit-config.yaml \
  && rm -rf /tmp/pre-commit_hook ; fi

WORKDIR /

# essential tools
RUN micromamba install fd-find ripgrep

# TODO: oh-my-bash
# RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# --- only patch locally ---
RUN unset http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY
RUN echo "unset http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY" >>~/.bashrc
