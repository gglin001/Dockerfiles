# docker build -t oneapi-construction-kit:latest -f oneapi-construction-kit/Dockerfile .

FROM spirv:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

RUN micromamba install lit -y

WORKDIR /home
