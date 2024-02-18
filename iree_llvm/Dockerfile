# docker build -t iree_llvm:latest -f iree_llvm/Dockerfile \
# --build-arg SHA="f01ed3bc8884223bf3edbaad8d3685622444cbf5" .

FROM base:latest

ARG SHA="f01ed3bc8884223bf3edbaad8d3685622444cbf5"

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /

# https://github.com/shark-infra/llvm-project
RUN git clone -n --depth=1 --filter=tree:0 https://github.com/shark-infra/llvm-project.git iree-llvm-project && \
  pushd iree-llvm-project && \
  git fetch --depth 1 origin $SHA && \
  git checkout $SHA && \
  popd

# TODO: better to use `build_tools/llvm` ?
# # https://github.com/openxla/iree/tree/main/build_tools/llvm
# RUN git clone -n --depth=1 --filter=tree:0 -b main https://github.com/openxla/iree.git iree_part && \
#   pushd iree_part && \
#   git sparse-checkout set --no-cone build_tools/llvm && \
#   popd

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

RUN micromamba install numpy pybind11 -y

# build llvm
# options come from
# https://github.com/openxla/iree/tree/main/build_tools/cmake/iree_llvm.cmake
# options needs update if iree update
RUN pushd iree-llvm-project && \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_C_COMPILER=/usr/bin/clang \
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DLLVM_ENABLE_WARNINGS=ON \
  -DLLVM_INCLUDE_EXAMPLES=OFF \
  -DLLVM_INCLUDE_TESTS=OFF \
  -DLLVM_INCLUDE_UTILS=ON \
  -DLLVM_INSTALL_UTILS=ON \
  -DLLVM_INCLUDE_BENCHMARKS=OFF \
  -DLLVM_APPEND_VC_REV=OFF \
  -DLLVM_ENABLE_IDE=ON \
  -DLLVM_ENABLE_BINDINGS=OFF \
  -DLLVM_TARGETS_TO_BUILD="host;RISCV;AArch64" \
  -DLLVM_ENABLE_PROJECTS="mlir;clang;lld" \
  -DMLIR_ENABLE_BINDINGS_PYTHON=ON \
  -DMHLO_ENABLE_BINDINGS_PYTHON=ON \
  -S$PWD/llvm -B$PWD/build -GNinja && \
  cmake --build $PWD/build --target install && \
  popd
