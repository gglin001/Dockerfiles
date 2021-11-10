FROM ubuntu:18.04

RUN apt update

RUN apt install -y git vim wget  bash-completion

RUN apt install -y lsb-release wget software-properties-common
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

RUN apt install ninja-build

RUN mkdir /root/cmake
WORKDIR /root/cmake

# RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.0-rc2/cmake-3.22.0-rc2-linux-x86_64.sh
# RUN cmod +x cmake-3.22.0-rc2-linux-x86_64.sh
# RUN ./cmake-3.22.0-rc2-linux-x86_64.sh

RUN echo "hello"
