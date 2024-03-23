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
  tar xf openjdk.tar.gz && rm -rf openjdk.tar.gz
ENV PATH="/opt/jdk-17.0.2/bin:${PATH}"
# set jabba, for vscode scala plugin
RUN mkdir -p /root/.jabba/jdk
RUN ln -sf /opt/jdk-17.0.2 /root/.jabba/jdk/openjdk@1.17.0

# sbt
# https://github.com/sbt/sbt
RUN wget --progress=bar:force:noscroll https://github.com/sbt/sbt/releases/download/v1.9.9/sbt-1.9.9.tgz -O sbt.tgz && \
  tar xf sbt.tgz && rm -rf sbt.tgz
ENV PATH="/opt/sbt/bin:${PATH}"

# scala-cli
# https://scala-cli.virtuslab.org/install/
RUN curl -sSLf https://scala-cli.virtuslab.org/get | sh

# millw/mill
# https://github.com/lefou/millw
RUN curl -L https://raw.githubusercontent.com/lefou/millw/0.4.11/millw > mill && chmod +x mill
RUN mkdir -p /opt/millw && mv mill /opt/millw/mill
ENV PATH="/opt/millw:${PATH}"
