# docker build -t mesa:latest -f mesa/Dockerfile .

FROM vulkan:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

RUN micromamba install -y meson mako
RUN micromamba install -y bison flex
RUN micromamba install -y pyyaml
RUN micromamba install -y libdrm
# wayland
RUN micromamba install -y wayland wayland-protocols
# x11
RUN micromamba install xorg-libx11 xorg-libxext xorg-libxfixes
RUN micromamba install xorg-libxshmfence xorg-libxxf86vm xorg-libxrandr

WORKDIR /home
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.6/libclc-19.1.6.src.tar.xz && tar xf libclc-19.1.6.src.tar.xz
WORKDIR /home/libclc-19.1.6.src
RUN \
  cmake \
  -DCMAKE_INSTALL_PREFIX=/opt/libclc \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_MODULE_PATH=$CONDA_PREFIX/lib/cmake/llvm:/opt/spirv-tools/lib/cmake/SPIRV-Tools \
  -DLLVM_SPIRV=/opt/llvm-spirv/bin/llvm-spirv \
  -DLIBCLC_TARGETS_TO_BUILD="clspv--;clspv64--;spirv-mesa3d-;spirv64-mesa3d-" \
  -S$PWD -B$PWD/build -GNinja && \
  cmake --build $PWD/build --target install

WORKDIR /home
RUN git clone https://gitlab.freedesktop.org/mesa/mesa.git mesa --single-branch -b 24.3 --depth 1
# RUN git clone https://gitlab.freedesktop.org/mesa/mesa.git mesa --single-branch -b main --depth 1
WORKDIR /home/mesa
RUN \
  PKG_CONFIG_PATH=/opt/spirv-tools/lib/pkgconfig:/opt/llvm-spirv/lib/pkgconfig:/opt/libclc/share/pkgconfig:$PKG_CONFIG_PATH \
  CC=/usr/bin/clang CXX=/usr/bin/clang++ \
  meson setup --reconfigure build \
  --buildtype=release \
  -Dprefix=/opt/mesa \
  -Dplatforms=wayland,x11 \
  -Dopengl=true \
  -Dgles1=disabled \
  -Dgles2=disabled \
  -Dglx=dri \
  -Degl=disabled \
  -Dllvm=enabled \
  -Dshared-llvm=disabled \
  -Ddraw-use-llvm=true \
  -Dgallium-drivers="llvmpipe" \
  -Dgallium-opencl=icd \
  -Dgallium-rusticl=false \
  -Dopencl-spirv=true \
  -Dvulkan-drivers="swrast" \
  -Dstatic-libclc=all \
  -Dperfetto=false \
  -Dbuild-tests=false \
  -Denable-glcpp-tests=false && \
  meson compile -C build && \
  meson install -C build

RUN echo "export VK_ICD_FILENAMES=$(ls -q /opt/mesa/share/vulkan/icd.d/*.json)" >> /root/.bashrc

WORKDIR /home
