# docker build -t mesa:latest -f mesa/Dockerfile .

FROM vulkan:latest

ENV DEBIAN_FRONTEND=noninteractive

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

RUN micromamba install -y meson mako
RUN micromamba install -y bison flex
RUN micromamba install -y libdrm
RUN micromamba install -y wayland wayland-protocols

WORKDIR /home
RUN git clone https://gitlab.freedesktop.org/mesa/mesa.git mesa --single-branch -b 24.0 --depth 1
# RUN git clone https://gitlab.freedesktop.org/mesa/mesa.git mesa --single-branch -b main --depth 1
WORKDIR /home/mesa
RUN \
  PKG_CONFIG_PATH=/opt/spirv-tools/lib/pkgconfig:/opt/llvm-spirv/lib/pkgconfig:$PKG_CONFIG_PATH \
  CC=/usr/bin/clang CXX=/usr/bin/clang++ \
  meson setup --reconfigure build \
  --buildtype=release \
  -Dprefix=/opt/mesa \
  -Dplatforms=wayland \
  -Dopengl=true \
  -Dgles1=disabled \
  -Dgles2=disabled \
  -Dglx=disabled \
  -Degl=disabled \
  -Dllvm=enabled \
  -Ddraw-use-llvm=true \
  -Dgallium-drivers="swrast" \
  -Dgallium-opencl=disabled \
  -Dgallium-rusticl=false \
  -Dopencl-spirv=false \
  -Dvulkan-drivers="swrast" \
  -Dperfetto=false \
  -Dbuild-tests=false \
  -Denable-glcpp-tests=false && \
  meson compile -C build && \
  meson install -C build

WORKDIR /home
