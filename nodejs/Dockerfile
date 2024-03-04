# docker build -t nodejs:latest -f nodejs/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# npm
RUN micromamba install nodejs=20
