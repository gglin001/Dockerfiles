# docker build -t spirv:latest -f spirv/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

RUN micromamba install -y clangdev=18.1 llvmdev=18.1 clang-tools=18.1
RUN micromamba install -y libhwloc pkg-config cmake ninja
RUN micromamba install -y patchelf

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

# TODO: add SPIRV-Cross
# https://github.com/KhronosGroup/SPIRV-Cross

WORKDIR /home
