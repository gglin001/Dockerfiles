# docker build -t qemu:latest -f qemu/Dockerfile .

# `riscv/Dockerfile.gcc`
FROM riscv-gnu-toolchain:latest-gcc AS stage-riscv

# FROM ubuntu:22.04
# FROM buildpack-deps:jammy
FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV RISCV=/opt/riscv
ENV QEMU=/opt/qemu

# copy riscv toolchain
COPY --from=stage-riscv $RISCV $RISCV

# qemu
WORKDIR /home
RUN git clone https://github.com/qemu/qemu --single-branch -b v8.2.1 --depth 1
WORKDIR /home/qemu
RUN mkdir build
WORKDIR /home/qemu/build
RUN ../configure --target-list="riscv64-softmmu riscv32-softmmu riscv64-linux-user riscv32-linux-user" --prefix=$QEMU
RUN make -j`nproc`
RUN make install

# update PATH
ENV PATH="/opt/qemu/bin:${PATH}"
ENV PATH="/opt/riscv/bin:${PATH}"
