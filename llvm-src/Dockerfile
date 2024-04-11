# docker build -t llvm-src:latest -f llvm-src/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /

# v18.1.3
ARG SHA="c13b7485b87909fcf739f62cfa382b55407433c0"

RUN git clone -n --depth=1 --filter=tree:0 https://github.com/llvm/llvm-project.git llvm-project && \
  pushd llvm-project && \
  git sparse-checkout set --no-cone /clang /cmake /libunwind /lld /llvm /mlir && \
  git sparse-checkout set --no-cone '!/clang/test' '!/llvm/test' '!/mlir/test' && \
  git fetch --depth 1 origin $SHA && \
  git checkout -b nb $SHA && \
  popd
