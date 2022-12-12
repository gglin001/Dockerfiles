# docker build -t popart_dev:latest -f popart/Dockerfile .

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# apt install basic tools
RUN apt update
RUN apt install wget -y

# gcc
RUN apt install gcc-9 g++-9 -y
RUN ln -sf /usr/bin/gcc-9 /usr/bin/gcc
RUN ln -sf /usr/bin/g++-9 /usr/bin/g++
RUN ln -sf /usr/bin/gcov-9 /usr/bin/gcov

# install conda

# install Mambaforge
ENV PATH="/opt/conda/bin:${PATH}"
RUN wget --progress=bar:force:noscroll \
    https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh \
    && bash Mambaforge-Linux-x86_64.sh -b -p /opt/conda \
    && rm -f Mambaforge-Linux-x86_64.sh
RUN conda init bash

# use conda-forge
RUN conda config --add channels conda-forge
RUN conda config --set channel_priority strict

# create new env
RUN conda create -n pyenv python=3.8 -y

RUN sed -e '/[ -z "$PS1" ] && return/s/^/#/g' -i ~/.bashrc
# set default conda env
RUN echo "export PROMPT_DIRTRIM=1" >> ~/.bashrc
RUN echo "conda activate pyenv" >> ~/.bashrc

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

RUN mamba install git -y
RUN mamba install ninja make pkg-config -y
RUN mamba install cmake==3.22.3 clang-tools clang-format -y

# -- THIRD PARTY LIBRARIES --

# Spdlog 1.8.0
WORKDIR /workspace/libs/third-party/
ENV SPDLOG_INSTALL_DIR /workspace/libs/third-party/spdlog-1.8.0/install_dir/
RUN git clone --branch v1.8.0 https://github.com/gabime/spdlog.git spdlog-1.8.0
WORKDIR spdlog-1.8.0
RUN mkdir build
WORKDIR build
RUN cmake .. -GNinja -DCMAKE_INSTALL_PREFIX=$SPDLOG_INSTALL_DIR && cmake --build . --target install

# Pybind11 2.6.2
WORKDIR /workspace/libs/third-party/
ENV PYBIND11_INSTALL_DIR /workspace/libs/third-party/pybind11-2.6.2/install_dir/
RUN wget https://github.com/pybind/pybind11/archive/v2.6.2.tar.gz
RUN tar xvfz v2.6.2.tar.gz
RUN rm v2.6.2.tar.gz
WORKDIR /workspace/libs/third-party/pybind11-2.6.2
RUN mkdir build
RUN mkdir install_dir
WORKDIR /workspace/libs/third-party/pybind11-2.6.2/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=$PYBIND11_INSTALL_DIR -DCMAKE_GENERATOR="Ninja"
RUN ninja
RUN ninja install

# Boost 1.70.0
WORKDIR /workspace/libs/third-party/
ENV BOOST_INSTALL_DIR /workspace/libs/third-party/boost_1_70_0/install_dir/
RUN wget https://sourceforge.net/projects/boost/files/boost/1.70.0/boost_1_70_0.tar.gz
RUN tar xvfz boost_1_70_0.tar.gz
RUN rm boost_1_70_0.tar.gz
WORKDIR /workspace/libs/third-party/boost_1_70_0
RUN mkdir install_dir
RUN ./bootstrap.sh --prefix=$BOOST_INSTALL_DIR
RUN ./b2 -j`nproc` link=static runtime-link=static --abbreviate-paths variant=release toolset=gcc "cxxflags= -fno-semantic-interposition -fPIC" cxxstd=14 --with-test --with-system --with-filesystem --with-program_options --with-graph --with-random install

# Protobuf 3.6.1
WORKDIR /workspace/libs/third-party/
ENV PROTOBUF_INSTALL_DIR /workspace/libs/third-party/protobuf-3.6.1/install_dir/
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protobuf-cpp-3.6.1.tar.gz
RUN tar xvfz protobuf-cpp-3.6.1.tar.gz
RUN rm protobuf-cpp-3.6.1.tar.gz
WORKDIR /workspace/libs/third-party/protobuf-3.6.1
RUN mkdir install_dir
RUN CXXFLAGS=-fPIC CFLAGS=-fPIC ./configure --prefix=/workspace/libs/third-party/protobuf-3.6.1/install_dir/
RUN make -j`nproc`
# RUN make check
RUN make install

# ONNX 1.6.0
RUN ln -s /usr/bin/python3 /usr/bin/python
WORKDIR /workspace/libs/third-party/
ENV ONNX_INSTALL_DIR /workspace/libs/third-party/onnx-1.6.0/install_dir/
RUN wget https://github.com/onnx/onnx/archive/v1.6.0.tar.gz
RUN tar xvfz v1.6.0.tar.gz
RUN rm v1.6.0.tar.gz
WORKDIR /workspace/libs/third-party/onnx-1.6.0
RUN mkdir build
RUN mkdir install_dir
WORKDIR /workspace/libs/third-party/onnx-1.6.0/build
RUN cmake .. -DONNX_ML=0 -DProtobuf_PROTOC_EXECUTABLE=$PROTOBUF_INSTALL_DIR/bin/protoc -DCMAKE_INSTALL_PREFIX=$ONNX_INSTALL_DIR -GNinja
RUN cmake --build . --target install

# CapnProto 0.7.0
WORKDIR /workspace/libs/third-party/
ENV CAPNPROTO_INSTALL_DIR /workspace/libs/third-party/capnproto-c++-0.7.0/install_dir/
RUN wget https://capnproto.org/capnproto-c++-0.7.0.tar.gz
RUN tar xvfz capnproto-c++-0.7.0.tar.gz
RUN rm capnproto-c++-0.7.0.tar.gz
WORKDIR /workspace/libs/third-party/capnproto-c++-0.7.0
RUN ./configure --prefix=$CAPNPROTO_INSTALL_DIR
# RUN make -j`nproc` check
RUN make install

# Tell pkg-config where to find CapnProto
ENV PKG_CONFIG_PATH=$CAPNPROTO_INSTALL_DIR/lib/pkgconfig:$PKG_CONFIG_PATH

# Trompeloeil v35
WORKDIR /workspace/libs/third-party/
ENV TROMPELOEIL_INSTALL_DIR /workspace/libs/third-party/trompeloeil-35/install_dir/
RUN wget https://github.com/rollbear/trompeloeil/archive/refs/tags/v35.tar.gz
RUN tar xvfz v35.tar.gz
RUN rm v35.tar.gz
WORKDIR /workspace/libs/third-party/trompeloeil-35
RUN mkdir build
WORKDIR /workspace/libs/third-party/trompeloeil-35/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=$TROMPELOEIL_INSTALL_DIR
RUN cmake --build . --target install

# NOTE:
# install pip pkgs in the container
# pip3 install -r requirements/build.txt

# RUN apt install rdma-core librdmacm1 ibverbs-utils -y

WORKDIR /workspace
