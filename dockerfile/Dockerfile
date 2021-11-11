# docker build -t llvm_build:13 dockerfile/

FROM ubuntu:18.04

WORKDIR /root

RUN apt update
RUN apt install -y apt-utils
RUN apt install -y git vim wget bash-completion
RUN apt install -y lsb-release wget software-properties-common

# RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
RUN wget https://apt.llvm.org/llvm.sh
RUN chmod +x llvm.sh
RUN ./llvm.sh 13

RUN apt install ninja-build

RUN wget -q https://github.com/Kitware/CMake/releases/download/v3.21.4/cmake-3.21.4-linux-x86_64.tar.gz && tar -zxf cmake-3.21.4-linux-x86_64.tar.gz
ENV PATH=/root/cmake-3.21.4-linux-x86_64/bin:$PATH
RUN which cmake

# get llvm in container or mount from host
# docker run --rm -it llvm_build:13
# cd /root
# git clone https://github.com/llvm/llvm-project --depth=1 --single-branch -b main

RUN echo "hello"
