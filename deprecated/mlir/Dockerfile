# docker build --no-cache -t mlir_dev:latest .
# docker build -t mlir_dev:latest .

# FROM continuumio/miniconda3
# prefer to use miniforge3
# FROM condaforge/miniforge3
FROM condaforge/mambaforge

# install basic tools
RUN apt update && apt install vim unzip -y
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

# use conda-forge
RUN conda config --add channels conda-forge
RUN conda config --set channel_priority strict

# create new env
RUN conda create -n py38 python=3.8 -y

# make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "py38", "/bin/bash", "-c"]

# install tools
# install clang from https://apt.llvm.org
RUN mamba install gcc gxx cmake ninja -y

# install libs
# RUN mamba install boost protobuf -y
RUN mamba install glog -y

# install other tools
RUN mamba install bash-completion openssh curl -y

# install requirements for llvm
RUN apt install -y lsb-release wget software-properties-common gnupg
RUN apt install -y sudo

# set env
RUN echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/opt/conda/envs/py38/lib" >> ~/.bashrc
RUN echo "export LIBRARY_PATH=\$LIBRARY_PATH:/opt/conda/envs/py38/lib" >> ~/.bashrc
RUN echo "export PROMPT_DIRTRIM=1" >> ~/.bashrc
RUN echo "conda activate py38" >> ~/.bashrc
