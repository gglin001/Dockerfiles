# docker build -t torchdev:latest .
# docker build -t torchdev:latest --no-cache .

FROM condaforge/mambaforge

ENV DEBIAN_FRONTEND=noninteractive

# install basic tools
RUN apt update && apt install vim unzip -y

# use conda-forge
RUN conda config --add channels conda-forge
RUN conda config --set channel_priority strict

# create new env
RUN conda create -n pyenv python=3.8 -y

# make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "pyenv", "/bin/bash", "-c"]

# install tools
# mamba install mlir libcxx
RUN mamba install clang=14 clangxx=14 clang-tools gcc=11 gxx=11 cmake ninja binutils -y
RUN mamba install sysroot_linux-64=2.17

# install other tools
RUN mamba install bash-completion openssh curl -y

# install others
RUN apt install sudo -y

# set env
RUN echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/opt/conda/envs/pyenv/lib" >> ~/.bashrc
RUN echo "export LIBRARY_PATH=\$LIBRARY_PATH:/opt/conda/envs/pyenv/lib" >> ~/.bashrc
RUN echo "export PROMPT_DIRTRIM=1" >> ~/.bashrc
RUN echo "conda activate pyenv" >> ~/.bashrc
