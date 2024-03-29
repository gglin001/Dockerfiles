# docker build -t swiftshader:latest -f swiftshader/Dockerfile .

FROM vulkan:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

WORKDIR /home
RUN git clone https://github.com/google/swiftshader.git swiftshader --single-branch -b master --depth 1
WORKDIR /home/swiftshader
RUN curl -O https://gerrit-review.googlesource.com/tools/hooks/commit-msg && mv commit-msg .git/hooks/
# no submodule download
RUN \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
  -DCMAKE_C_COMPILER=/usr/bin/clang \
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DSWIFTSHADER_BUILD_BENCHMARKS=OFF \
  -DSWIFTSHADER_BUILD_TESTS=OFF \
  -DBUILD_VULKAN_WRAPPER=OFF \
  -DSWIFTSHADER_LLVM_VERSION=16.0 \
  -S$PWD -B$PWD/build -GNinja && \
  cmake --build $PWD/build --target install

ENV VK_ICD_FILENAMES=/home/swiftshader/build/Linux/vk_swiftshader_icd.json

WORKDIR /home
