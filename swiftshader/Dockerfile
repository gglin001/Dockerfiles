# docker build -t swiftshader:latest -f swiftshader/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

# swiftshader
WORKDIR /home
RUN git clone https://github.com/google/swiftshader.git --single-branch -b master --depth 1
# RUN git clone https://swiftshader.googlesource.com/SwiftShader swiftshader --single-branch -b master --depth 1
WORKDIR /home/swiftshader
RUN curl -O https://gerrit-review.googlesource.com/tools/hooks/commit-msg && mv commit-msg .git/hooks/
# RUN git submodule init
# RUN git submodule deinit third_party/llvm-project third_party/PowerVR_Examples
# RUN git submodule deinit third_party/benchmark third_party/googletest
# RUN git submodule deinit third_party/glslang
# RUN git submodule update --recursive --depth 1
RUN cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PWD/build/install \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_C_COMPILER=/usr/bin/clang \
  -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DSWIFTSHADER_BUILD_BENCHMARKS=OFF \
  -DSWIFTSHADER_BUILD_TESTS=OFF \
  -DBUILD_VULKAN_WRAPPER=OFF \
  -DSWIFTSHADER_LLVM_VERSION=16.0 \
  -S$PWD -B$PWD/build -GNinja && \
  cmake --build $PWD/build --target install

# update PATH
ENV PATH="/opt/swiftshader/build/bin:${PATH}"
