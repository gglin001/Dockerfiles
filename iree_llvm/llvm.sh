#!/bin/bash

# get LLVM_SHA, `git submodule init` is done brefore
git submodule status

# LLVM_SHA="c54064de80e93494d1d44550b56ce8f2f3cf9c4b"
# LLVM_SHA="a36e85f10497924ed996c1a9b82f26d004713d54"
LLVM_SHA="9708d0900311503aa4685d6810d8caf0412e15d7"

# `/iree-llvm-project` is where llvm mounted
pushd /iree-llvm-project
git fetch --depth 1 origin $LLVM_SHA
git checkout $LLVM_SHA
popd

# cmake options sync with `iree_llvm/Dockerfile`
pushd /iree-llvm-project &&
  cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DCMAKE_C_COMPILER=/usr/bin/clang \
    -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
    -DLLVM_ENABLE_ASSERTIONS=ON \
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
    -S$PWD/llvm -B$PWD/build -GNinja &&
  cmake --build $PWD/build --target install &&
  popd
