# docker build -t gem5:latest -f gem5/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# clangd
RUN micromamba install clang-tools

# sync with gem5 `util/dockerfiles/ubuntu-22.04_all-dependencies/Dockerfile`
RUN apt -y update && apt -y upgrade && \
    apt -y install build-essential git m4 scons zlib1g zlib1g-dev \
    libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev \
    python3-dev doxygen libboost-all-dev libhdf5-serial-dev python3-pydot \
    libpng-dev libelf-dev pkg-config pip python3-venv black python3-tk wget
RUN pip install mypy pre-commit
RUN pip install -U scons
