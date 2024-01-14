docker buildx create --name multiarch --driver docker-container --use

# docker buildx build \
#     --platform=linux/amd64,linux/arm64 \
#     --load \
#     -t test .

docker buildx build \
    --platform=linux/arm64 \
    --load \
    -t test:arm64 .

docker buildx build \
    --platform=linux/amd64 \
    --load \
    -t test:amd64 .

docker buildx build \
    --platform=linux/riscv64 \
    --load \
    -t test:riscv64 \
    -f Dockerfile.riscv64 .

# --platform=linux/amd64,linux/arm64,linux/riscv64 \
# --platform=linux/amd64,linux/arm64 \
# --platform=linux/amd64 \
# --platform=linux/amd64,linux/riscv64 \
# --platform=linux/amd64,linux/arm64 \
# --platform=linux/amd64,linux/386 \

# docker run --privileged --rm tonistiigi/binfmt --install all
