# docker build -t spike:latest -f spike/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV SPIKE=/opt/spike

# spike
WORKDIR /home
RUN git clone https://github.com/riscv-software-src/riscv-isa-sim --single-branch -b master --depth 1
WORKDIR /home/riscv-isa-sim
RUN mkdir build
WORKDIR /home/riscv-isa-sim/build
RUN ../configure --prefix=$SPIKE
RUN make -j`nproc`
RUN make install

# update PATH
ENV PATH="/opt/spike/bin:${PATH}"
