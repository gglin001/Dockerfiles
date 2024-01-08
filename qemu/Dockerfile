# docker build -t qemu:latest .

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# install basic tools
RUN apt update && apt install git vim sudo -y
RUN apt install make meson ninja-build -y
RUN apt install python3 python3-pip -y

# qemu
ENV QEMU=/opt/qemu
WORKDIR /home
RUN git clone https://github.com/qemu/qemu -b v8.1.2 --depth 1
RUN apt install ninja-build pkg-config libglib2.0-dev libpixman-1-dev -y
WORKDIR /home/qemu
RUN mkdir build
WORKDIR /home/qemu/build
RUN ../configure --target-list="riscv64-softmmu riscv32-softmmu" --prefix=$QEMU
RUN ../configure --target-list="riscv64-linux-user riscv32-linux-user" --prefix=$QEMU
RUN make -j`nproc`
RUN make install

# update PATH
ENV PATH="/opt/qemu/bin:${PATH}"
