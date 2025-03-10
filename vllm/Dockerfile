# docker build -t vllm:latest -f vllm/Dockerfile .

FROM nvcr.io/nvidia/pytorch:24.10-py3
# FROM nvcr.io/nvidia/pytorch:25.02-py3

ENV DEBIAN_FRONTEND=noninteractive

# micromamba
RUN curl -LO micro.mamba.pm/install.sh
RUN bash install.sh
RUN rm -f install.sh

RUN sed -e '/[ -z "$PS1" ] && return/s/^/#/g' -i ~/.bashrc
# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]
RUN micromamba config append channels conda-forge
RUN micromamba create -n pyenv python=3.10 -y

# set default env
# RUN echo "micromamba activate pyenv" >> ~/.bashrc

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# micromamba
RUN micromamba install clang-tools -y

# TODO: deal vllm depdency
