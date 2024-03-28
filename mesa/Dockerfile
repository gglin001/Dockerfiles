# docker build -t mesa:latest -f mesa/Dockerfile .

FROM spirv:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

RUN micromamba install libxcb


WORKDIR /home
