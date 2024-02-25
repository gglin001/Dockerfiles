# docker build -t nix:latest -f nix/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

# https://nixos.org/download
RUN sh <(curl -L https://nixos.org/nix/install) --daemon --yes
