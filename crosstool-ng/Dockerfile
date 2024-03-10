# docker build -t crosstool-ng:latest -f crosstool-ng/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV CTNG=/opt/crosstool-ng

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# deps
RUN micromamba install libtool flex bison help2man texinfo gawk -y

WORKDIR /home
# build crosstool-ng
RUN git clone https://github.com/crosstool-ng/crosstool-ng.git --single-branch -b crosstool-ng-1.26.0 --depth 1
WORKDIR /home/crosstool-ng
RUN ./bootstrap && \
  mkdir build && cd build && \
  ../configure --prefix=$CTNG && \
  make -j`nproc` && \
  make install

WORKDIR $CTNG

ENV PATH="$CTNG/bin:${PATH}"
