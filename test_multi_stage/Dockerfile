# docker build -t test_multi_stage_0:latest --target build -f test_multi_stage/Dockerfile .
# docker build -t test_multi_stage_1:latest --target deploy -f test_multi_stage/Dockerfile .

FROM ubuntu:22.04 AS base

WORKDIR /workspace

RUN echo "shared file" > file.txt

FROM base AS build

FROM buildpack-deps:22.04 AS deploy

RUN --mount=type=bind,from=build,src=/workspace,target=/workspace \
  cp /workspace/file.txt /root/file.txt
