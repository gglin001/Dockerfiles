# docker build -t chisel:latest -f chisel/Dockerfile .

FROM base:latest

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /opt

# openjdk 17
# https://jdk.java.net/archive/
# https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-aarch64_bin.tar.gz
# https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz
# TODO, use `$(uname -m)` detect arch
RUN wget --progress=bar:force:noscroll https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-aarch64_bin.tar.gz -O openjdk.tar.gz && \
  tar xf openjdk.tgz && rm -rf openjdk.tar.gz
ENV PATH="/opt/jdk-17.0.2/bin:${PATH}"
# set jabba
RUN ln -sf /opt/jdk-17.0.2 /root/.jabba/jdk/openjdk@1.17.0

# sbt
RUN wget --progress=bar:force:noscroll https://github.com/sbt/sbt/releases/download/v1.9.9/sbt-1.9.9.tgz -O sbt.tgz && \
  tar xf sbt.tgz && rm -rf sbt.tgz
ENV PATH="/opt/sbt/bin:${PATH}"
