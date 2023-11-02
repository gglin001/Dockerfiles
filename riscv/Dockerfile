# docker build -t riscv-gnu-toolchain:latest .

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV RISCV=/opt/riscv

# install basic tools
RUN apt update && apt install git vim sudo -y

# riscv-gnu-toolchain
WORKDIR /home
RUN git clone https://github.com/riscv-collab/riscv-gnu-toolchain
# sometimes submodule sync will fail
WORKDIR /home/riscv-gnu-toolchain
RUN git submodule update --init --recursive
# from https://github.com/riscv-collab/riscv-gnu-toolchain
RUN sudo apt-get -y install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev
# just newlib
WORKDIR /home/riscv-gnu-toolchain
RUN ./configure --prefix=$RISCV
RUN make -j `nproc`
RUN make install

# update PATH
ENV PATH="/opt/riscv/bin:${PATH}"
