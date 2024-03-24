# docker build -t pocl:latest -f pocl/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# let `llvm-spirv` define `llvmdev` version
RUN micromamba install -y llvm-spirv clangdev llvmdev
RUN micromamba install -y libhwloc pkg-config cmake ninja
RUN micromamba install -y patchelf

# optional, skip if just pocl is used
# RUN micromamba install -y ocl-icd clhpp
