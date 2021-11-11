cmake --build \
    /root/llvm-project/build \
    --config Debug \
    --target all \
    -j $(grep -c ^processor /proc/cpuinfo) --
