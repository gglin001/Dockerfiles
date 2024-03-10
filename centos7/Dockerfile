# docker build -t centos7:latest -f centos7/Dockerfile .
# docker build --platform linux/amd64 -t centos7:latest -f centos7/Dockerfile .

FROM centos:centos7

# micromamba
RUN curl -LO micro.mamba.pm/install.sh
RUN yes y | bash install.sh
RUN rm -f install.sh

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]
RUN micromamba config append channels conda-forge
RUN micromamba create -n pyenv python=3.12 -y

# set default env
RUN echo "export PROMPT_DIRTRIM=1" >> ~/.bashrc
RUN echo "micromamba activate pyenv" >> ~/.bashrc

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# compilers
RUN micromamba install clang clangxx -y
RUN micromamba install gcc gxx -y

# tools
RUN micromamba install clang-tools -y
RUN micromamba install cmake ninja -y
RUN micromamba install bash-completion -y
RUN micromamba install git -y

# optional libs
# RUN micromamba install clangdev llvmdev -y
