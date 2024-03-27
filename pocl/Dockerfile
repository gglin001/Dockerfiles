# docker build -t pocl:latest -f pocl/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

RUN micromamba install -y clangdev=18.1 llvmdev=18.1 clang-tools=18.1
RUN micromamba install -y libhwloc pkg-config cmake ninja
RUN micromamba install -y patchelf
# RUN micromamba install -y clinfo

WORKDIR /home
RUN git clone https://github.com/KhronosGroup/SPIRV-Headers spirv-headers --single-branch -b vulkan-sdk-1.3.280.0 --depth 1
WORKDIR /home/spirv-headers

WORKDIR /home
RUN git clone https://github.com/KhronosGroup/SPIRV-Tools spirv-tools --single-branch -b vulkan-sdk-1.3.280.0 --depth 1
WORKDIR /home/spirv-tools
RUN \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt/spirv-tools \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
  -DCMAKE_C_COMPILER=/usr/bin/clang \
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DSPIRV-Headers_SOURCE_DIR=/home/spirv-headers \
  -DSPIRV_SKIP_TESTS=ON \
  -S$PWD -B$PWD/build -GNinja && \
  cmake --build $PWD/build --target install

ENV PATH="/opt/spirv-tools/bin:${PATH}"

WORKDIR /home
RUN git clone https://github.com/KhronosGroup/SPIRV-LLVM-Translator llvm-spirv --single-branch -b v18.1.0 --depth 1
WORKDIR /home/llvm-spirv
RUN \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_PREFIX_PATH=/opt/spirv-tools \
  -DCMAKE_INSTALL_PREFIX=/opt/llvm-spirv \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
  -DCMAKE_C_COMPILER=/usr/bin/clang \
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DLLVM_SPIRV_INCLUDE_TESTS=OFF \
  -DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR=/home/spirv-headers \
  -S$PWD -B$PWD/build -GNinja && \
  cmake --build $PWD/build --target install

ENV PATH="/opt/llvm-spirv/bin:${PATH}"

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

# for some rpath issue:
# LD_LIBRARY_PATH="$CONDA_PREFIX/lib:/opt/pocl/lib:${LD_LIBRARY_PATH}"
# or use patchelf to solv it

# TODO: build clvk(without llvm src) ?
# https://github.com/kpet/clvk
