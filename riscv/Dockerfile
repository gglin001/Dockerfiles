# docker build -t riscv-dev:latest .

FROM ubuntu:20.04

ENV RISCV=/opt/riscv

# install basic tools
RUN apt update && apt install git vim sudo -y

# riscv-gnu-toolchain
WORKDIR /home
RUN git clone http://github.com/gglin001/riscv-gnu-toolchain
# sometimes submodule sync will fail
WORKDIR /home/riscv-gnu-toolchain
RUN git submodule update --init --recursive
# https://serverfault.com/questions/949991
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
# from https://github.com/riscv-collab/riscv-gnu-toolchain
RUN sudo apt-get install autoconf automake autotools-dev curl python3 \
    libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo \
    gperf libtool patchutils bc zlib1g-dev libexpat-dev -y
# just newlib
WORKDIR /home/riscv-gnu-toolchain
RUN ./configure --prefix=$RISCV
RUN make -j `nproc`
RUN make install

# update PATH
ENV PATH="/opt/riscv/bin:${PATH}"

# spike
WORKDIR /home
RUN git clone https://github.com/riscv-software-src/riscv-isa-sim
WORKDIR /home/riscv-isa-sim
RUN apt-get install device-tree-compiler -y
RUN mkdir build
WORKDIR /home/riscv-isa-sim/build
RUN ../configure --prefix=$RISCV
RUN make -j `nproc`
RUN make install

# riscv-pk
WORKDIR /home
RUN git clone https://github.com/riscv-software-src/riscv-pk
WORKDIR /home/riscv-pk
RUN mkdir build
WORKDIR /home/riscv-pk/build
RUN ../configure --prefix=$RISCV --host=riscv64-unknown-elf
RUN make -j `nproc`
RUN make install

# riscv-tests
WORKDIR /home
RUN git clone https://github.com/riscv-software-src/riscv-tests
WORKDIR /home/riscv-tests
RUN git submodule update --init --recursive
RUN autoconf
RUN ./configure --prefix=$RISCV/target
RUN make -j `nproc`
RUN make install

# show installed commands
RUN ls -l $RISCV/bin
