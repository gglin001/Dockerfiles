# docker build -t qemu:latest -f qemu/Dockerfile .

# FROM ubuntu:22.04
# FROM buildpack-deps:jammy
FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV QEMU=/opt/qemu

# qemu
WORKDIR /home
# RUN git clone https://github.com/qemu/qemu --single-branch -b v8.2.2 --depth 1
RUN git clone https://github.com/qemu/qemu --single-branch -b v9.0.0 --depth 1
WORKDIR /home/qemu
RUN mkdir build
WORKDIR /home/qemu/build
RUN ../configure --target-list="riscv64-softmmu riscv32-softmmu riscv64-linux-user riscv32-linux-user" --prefix=$QEMU
RUN make -j`nproc`
RUN make install

# update PATH
ENV PATH="/opt/qemu/bin:${PATH}"
