cmake --build \
    /root/llvm-project/build \
    --config Release \
    --target all \
    -j $(grep -c ^processor /proc/cpuinfo) --
