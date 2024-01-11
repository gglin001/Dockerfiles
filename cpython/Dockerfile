# docker build -t cpython:latest -f cpython/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# bear
RUN micromamba install bear -y
