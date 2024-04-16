# docker build -t llvm-src:latest -f llvm-src/Dockerfile \
# --build-arg LLVM_SHA="c13b7485b87909fcf739f62cfa382b55407433c0" \
# --build-arg LLVM_REPO="https://github.com/shark-infra/llvm-project.git" \
# .

# for llvm building with sparse-checkout src

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /

# v18.1.3
ARG LLVM_SHA="c13b7485b87909fcf739f62cfa382b55407433c0"
ARG LLVM_REPO="https://github.com/llvm/llvm-project.git"

RUN git clone -n --depth=1 --filter=tree:0 $LLVM_REPO llvm-project && \
  pushd llvm-project && \
  git sparse-checkout set --no-cone \
  /clang /cmake /libunwind /lld /llvm /mlir \
  '!/clang/test' '!/clang/unittests' '!/clang/docs' '!/clang/www' \
  '!/llvm/test' '!/llvm/unittests' '!/llvm/docs' \
  '!/mlir/test' '!/mlir/docs' !'/lld/test' && \
  git fetch --depth 1 origin $LLVM_SHA && \
  git checkout -b nb $LLVM_SHA && \
  popd

# TODO: add ref building commands for test
