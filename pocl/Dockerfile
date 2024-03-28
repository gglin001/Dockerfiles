# docker build -t pocl:latest -f pocl/Dockerfile .

FROM spirv:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

WORKDIR /home
RUN git clone https://github.com/gglin001/clspv.git clspv --single-branch -b allen/conda_build --depth 1
# RUN git clone https://github.com/google/clspv clspv --single-branch -b main --depth 1
WORKDIR /home/clspv
RUN \
  CLANGD_VERSION=$(clangd --version | grep -Po '(?<=clangd version )[^.]+') && \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
  -DCMAKE_C_COMPILER=/usr/bin/clang \
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DSPIRV_HEADERS_SOURCE_DIR=/home/spirv-headers \
  -DSPIRV_TOOLS_SOURCE_DIR=/home/spirv-tools \
  -DCLSPV_BUILD_TESTS=OFF \
  -DEXTERNAL_LLVM=1 \
  -DCLSPV_LLVM_BINARY_DIR=/root/micromamba/envs/pyenv \
  -DCLSPV_LLVM_SOURCE_DIR=/root/micromamba/envs/pyenv \
  -DCLSPV_CLANG_SOURCE_DIR=/root/micromamba/envs/pyenv/lib/clang/$CLANGD_VERSION/include \
  -S $PWD -B $PWD/build -GNinja && \
  cmake --build $PWD/build --target install

# `clspv-opt` is not a install target
ENV PATH="/home/clspv/build/bin:${PATH}"

WORKDIR /home
RUN git clone https://github.com/pocl/pocl pocl --single-branch -b main --depth 1
WORKDIR /home/pocl
RUN \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt/pocl \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
  -DCMAKE_C_COMPILER=/usr/bin/clang \
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DINSTALL_OPENCL_HEADERS=ON \
  -DENABLE_ICD=OFF \
  -DENABLE_TESTS=OFF \
  -DENABLE_EXAMPLES=ON \
  -DKERNELLIB_HOST_CPU_VARIANTS="generic" \
  -DLLC_HOST_CPU="generic" \
  -DCLANG_MARCH_FLAG="-mcpu=" \
  -S$PWD -B$PWD/build -GNinja && \
  cmake --build $PWD/build --target install && \
  patchelf --add-rpath "\$ORIGIN/../lib:\$ORIGIN/../lib/CL" /opt/pocl/bin/poclcc

# do not set pocl env
# ENV PATH="/opt/pocl/bin:${PATH}"

WORKDIR /home

# TODO: build clvk(without llvm src) ?
# https://github.com/kpet/clvk
