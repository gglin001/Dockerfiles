# docker build -t test_proxy:latest --progress=plain --no-cache -f test_proxy/Dockerfile .

FROM buildpack-deps:22.04

ENV DEBIAN_FRONTEND=noninteractive

# --- only patch locally ---
#  works for `RUN cmd`
ENV https_proxy=http://host.lima.internal:10800 http_proxy=http://host.lima.internal:10800

RUN curl ip.gs

# --- only patch locally ---
RUN unset http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY
RUN echo "unset http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY" >>~/.bashrc
