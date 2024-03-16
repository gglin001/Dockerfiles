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
RUN git fetch origin 36537f60e0a37876ed9b039304376188b0794ab5
RUN git reset --hard 36537f60e0a37876ed9b039304376188b0794ab5
# apply patch for picolibc_v186
COPY crosstool-ng/picolibc_v186.patch /home/crosstool-ng/
RUN git apply picolibc_v186.patch
RUN ./bootstrap && \
  mkdir build && cd build && \
  ../configure --prefix=$CTNG && \
  make -j`nproc` && \
  make install

WORKDIR $CTNG

ENV PATH="$CTNG/bin:${PATH}"
