# docker build -t llvm-src:latest -f llvm-src/Dockerfile .

# for llvm building with sparse-checkout src

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /

# v18.1.3
ARG SHA="c13b7485b87909fcf739f62cfa382b55407433c0"

RUN git clone -n --depth=1 --filter=tree:0 https://github.com/llvm/llvm-project.git llvm-project && \
  pushd llvm-project && \
  git sparse-checkout set --no-cone \
  /clang /cmake /libunwind /lld /llvm /mlir \
  '!/clang/test' '!/clang/unittests' '!/clang/docs' '!/clang/www' \
  '!/llvm/test' '!/llvm/unittests' '!/llvm/docs' \
  '!/mlir/test' '!/mlir/docs' !'/lld/test' && \
  git fetch --depth 1 origin $SHA && \
  git checkout -b nb $SHA && \
  popd

# TODO: add ref building commands for test
