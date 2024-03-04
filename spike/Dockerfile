# docker build -t spike:latest -f spike/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV SPIKE=/opt/spike

RUN apt update
RUN apt-get install device-tree-compiler -y

# spike
WORKDIR /home
RUN git clone https://github.com/riscv-software-src/riscv-isa-sim --single-branch -b master --depth 1
WORKDIR /home/riscv-isa-sim
RUN mkdir build
WORKDIR /home/riscv-isa-sim/build
# TODO: is boost libs needed ?
RUN ../configure --prefix=$SPIKE --with-boost-asio=no --with-boost-regex=no
RUN make -j`nproc`
RUN make install

# update PATH
ENV PATH="/opt/spike/bin:${PATH}"
