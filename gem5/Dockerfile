# docker build -t gem5:latest -f gem5/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# clangd
RUN micromamba install clang-tools