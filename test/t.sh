# https://docs.docker.com/build/building/multi-platform/
docker run --privileged --rm tonistiigi/binfmt --install all

docker buildx create --name multiarch --driver docker-container --use

# pwd is `test/`
# docker buildx build \
#     --platform=linux/amd64,linux/arm64 \
#     --load \
#     -t test .

docker buildx build \
    --platform=linux/arm64 \
    --load \
    -t test:arm64 \
    -f test/Dockerfile .

docker buildx build \
    --platform=linux/amd64 \
    --load \
    -t test:amd64 \
    -f test/Dockerfile .

docker buildx build \
    --platform=linux/riscv64 \
    --load \
    -t test:riscv64 \
    -f test/Dockerfile.riscv64 .

docker buildx build \
    --platform=linux/riscv64 \
    --load \
    -t test:riscv64.sid \
    -f test/Dockerfile.riscv64.sid .

# clean multiarch
docker buildx rm multiarch
# check current driver
docker buildx ls

# run test:riscv64.sid
docker run --rm -it --platform linux/riscv64 test:riscv64.sid bash
docker run --rm -it test:riscv64.sid bash
