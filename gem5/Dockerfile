# docker build -t gem5:latest -f gem5/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

RUN micromamba create -n gem5 python=3.10 -y
RUN sed -i -e 's/micromamba activate pyenv/# micromamba activate pyenv/g' ~/.bashrc
RUN echo "micromamba activate gem5" >> ~/.bashrc

# micromamba
RUN micromamba install cmake ninja -y
RUN micromamba install bash-completion -y
RUN micromamba install git openssh -y
RUN micromamba install clang-tools -y

# get clang headers from `clang` from conda
RUN CLANGD_VERSION=$(clangd --version | grep -Po '(?<=clangd version )[^.]+') && \
  micromamba install --download-only --no-deps clang-$CLANGD_VERSION && \
  cp -r $CONDA_PREFIX/../../pkgs/clang-$CLANGD_VERSION-*/lib/clang $CONDA_PREFIX/lib/

# for gem5
RUN micromamba install scons -y
RUN micromamba install pybind11 gperftools protobuf hdf5 -y
# libcapstone from conda has no aarch64 version
RUN apt install -y libcapstone-dev
