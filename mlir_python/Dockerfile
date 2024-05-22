# docker build -t mlir_python:latest -f mlir_python/Dockerfile \
# --build-arg LLVM_SHA="main" \
# --build-arg LLVM_REPO="https://github.com/llvm/llvm-project.git" \
# .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

ARG LLVM_SHA="main"
ARG LLVM_REPO="https://github.com/llvm/llvm-project.git"

RUN git clone -n --depth=1 --filter=tree:0 $LLVM_REPO llvm-project && \
  pushd llvm-project && \
  git sparse-checkout set --no-cone \
  /cmake /llvm /mlir \
  '!/llvm/test' '!/llvm/unittests' '!/llvm/docs' \
  '!/mlir/test' '!/mlir/docs' && \
  git fetch --depth 1 origin $LLVM_SHA && \
  git checkout -b nb $LLVM_SHA && \
  popd

RUN micromamba install numpy pybind11 -y

# RUN pushd llvm-project && \
#   cmake \
#   -DCMAKE_BUILD_TYPE=Release \
#   -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
#   -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
#   -DCMAKE_C_COMPILER=/usr/bin/clang \
#   -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
#   -DLLVM_ENABLE_ASSERTIONS=ON \
#   -DLLVM_ENABLE_WARNINGS=ON \
#   -DLLVM_INCLUDE_EXAMPLES=OFF \
#   -DLLVM_INCLUDE_TESTS=OFF \
#   -DLLVM_INCLUDE_UTILS=ON \
#   -DLLVM_INSTALL_UTILS=ON \
#   -DLLVM_INCLUDE_BENCHMARKS=OFF \
#   -DLLVM_APPEND_VC_REV=OFF \
#   -DLLVM_ENABLE_IDE=ON \
#   -DLLVM_ENABLE_BINDINGS=OFF \
#   -DLLVM_TARGETS_TO_BUILD="host;RISCV;AArch64" \
#   -DLLVM_ENABLE_PROJECTS="mlir;clang;lld" \
#   -DMLIR_ENABLE_BINDINGS_PYTHON=ON \
#   -S$PWD/llvm -B$PWD/build -GNinja && \
#   cmake --build $PWD/build --target install && \
#   popd
