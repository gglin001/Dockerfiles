# for riscv64

# https://docs.docker.com/build/building/multi-platform/
docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx create --name multiarch --driver docker-container --use
# after building
# docker buildx rm multiarch

docker buildx build --platform=linux/riscv64 --load -t pocl:latest-riscv -f pocl/Dockerfile.riscv .

docker run --rm -it --platform linux/riscv64 pocl:latest-riscv
uname -m
