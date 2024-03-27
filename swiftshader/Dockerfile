# docker build -t swiftshader:latest -f swiftshader/Dockerfile .

FROM spirv:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

RUN micromamba install libxcb

WORKDIR /home
RUN git clone https://github.com/KhronosGroup/Vulkan-Headers.git vulkan-headers --single-branch -b vulkan-sdk-1.3.280.0 --depth 1
WORKDIR /home/vulkan-headers
RUN \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt/vulkan-headers \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
  -DBUILD_TESTS=OFF \
  -S $PWD -B $PWD/build -GNinja && \
  cmake --build $PWD/build --target install

WORKDIR /home
RUN git clone https://github.com/KhronosGroup/Vulkan-Loader.git vulkan-loader --single-branch -b vulkan-sdk-1.3.280.0 --depth 1
WORKDIR /home/vulkan-loader
RUN \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt/vulkan-loader \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
  -DVulkanHeaders_DIR=/opt/vulkan-headers/share/cmake/VulkanHeaders \
  -DBUILD_WSI_XCB_SUPPORT=ON \
  -DBUILD_WSI_XLIB_SUPPORT=OFF \
  -DBUILD_WSI_WAYLAND_SUPPORT=OFF \
  -DBUILD_WSI_DIRECTFB_SUPPORT=OFF \
  -DBUILD_TESTS=OFF \
  -S $PWD -B $PWD/build -GNinja && \
  cmake --build $PWD/build --target install

WORKDIR /home
RUN git clone https://github.com/zeux/volk.git volk --single-branch -b vulkan-sdk-1.3.280.0 --depth 1
WORKDIR /home/volk
RUN \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt/volk \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
  -DVOLK_HEADERS_ONLY=OFF \
  -DVOLK_INSTALL=ON \
  -DVOLK_PULL_IN_VULKAN=ON \
  -DVOLK_INCLUDES=/opt/vulkan-headers/include \
  -S $PWD -B $PWD/build -GNinja && \
  cmake --build $PWD/build --target install

WORKDIR /home
RUN git clone https://github.com/KhronosGroup/Vulkan-Tools.git vulkan-tools --single-branch -b vulkan-sdk-1.3.280.0 --depth 1
WORKDIR /home/vulkan-tools
RUN \
  cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt/vulkan-tools \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
  -DVulkanHeaders_DIR=/opt/vulkan-headers/share/cmake/VulkanHeaders \
  -DVulkanLoader_DIR=/opt/vulkan-loader/lib/cmake/VulkanLoader \
  -Dvolk_DIR=/opt/volk/lib/cmake/volk \
  -DBUILD_WSI_XCB_SUPPORT=ON \
  -DBUILD_WSI_XLIB_SUPPORT=OFF \
  -DBUILD_WSI_WAYLAND_SUPPORT=OFF \
  -DBUILD_WSI_DIRECTFB_SUPPORT=OFF \
  -S $PWD -B $PWD/build -GNinja && \
  cmake --build $PWD/build --target install

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

ENV PATH="/opt/vulkan-tools/bin:${PATH}"
RUN patchelf --add-rpath "/opt/vulkan-loader/lib" /opt/vulkan-tools/bin/vulkaninfo

WORKDIR /home
