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
# TODO: seems no need here?
RUN mkdir -p /root/.jabba/jdk
RUN ln -sf /opt/jdk-17.0.2 /root/.jabba/jdk/openjdk@1.17.0

# sbt
# https://github.com/sbt/sbt
RUN wget --progress=bar:force:noscroll https://github.com/sbt/sbt/releases/download/v1.9.9/sbt-1.9.9.tgz -O sbt.tgz && \
  tar xf sbt.tgz && rm -rf sbt.tgz
ENV PATH="/opt/sbt/bin:${PATH}"

# scala-cli
# https://scala-cli.virtuslab.org/install/
RUN curl -fL https://github.com/Virtuslab/scala-cli/releases/latest/download/scala-cli-aarch64-pc-linux.gz | gzip -d > scala-cli-bin && \
  chmod +x scala-cli-bin && \
  mkdir -p /opt/scala-cli && \
  mv scala-cli-bin /opt/scala-cli/scala-cli
ENV PATH="/opt/scala-cli:${PATH}"

# millw/mill
# https://github.com/lefou/millw
RUN curl -L https://raw.githubusercontent.com/lefou/millw/0.4.11/millw > mill && chmod +x mill
RUN mkdir -p /opt/millw && mv mill /opt/millw/mill
ENV PATH="/opt/millw:${PATH}"

# coursier / cs
# https://get-coursier.io/docs/cli-installation
RUN mkdir -p /opt/coursier
# RUN curl -fL https://github.com/coursier/coursier/releases/latest/download/coursier > /opt/coursier/coursier
RUN curl -fL "https://github.com/VirtusLab/coursier-m1/releases/latest/download/cs-aarch64-pc-linux.gz" | gzip -d > /opt/coursier/cs && \
  chmod +x /opt/coursier/cs
ENV PATH="/opt/coursier:${PATH}"

# make RUN commands use the new environment:
SHELL ["bash", "-l", "-c"]

# install tools
RUN echo "export PATH=/root/.local/share/coursier/bin:\$PATH" >> ~/.bashrc
RUN cs install scalafmt
RUN cs install metals

# TODO:
# circt
# chisel
# verilator
