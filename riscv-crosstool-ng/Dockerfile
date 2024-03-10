# docker build -t riscv-crosstool-ng:latest -f riscv-crosstool-ng/Dockerfile .

FROM crosstool-ng:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV RISCV=/opt/riscv

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

WORKDIR /home

ENV PATH="$RISCV/bin:${PATH}"
