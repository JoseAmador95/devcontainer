FROM ubuntu:24.04

ARG LLVM_VERSION=18

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C
ENV PIPX_BIN_DIR=/usr/local/bin

# Update Ubuntu packages
RUN apt-get update \
 && apt-get upgrade -y --no-install-recommends \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
# Tar engine
    xz-utils \
# C/C++ compiler & build tools
    ninja-build \
    build-essential \
# ARM GCC Compiler
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
# Coverage report
    gcovr \
# Version control
    git \
# Debuging tools
    valgrind \
    gdb \
# Documentation generation
    doxygen \
    graphviz \
# Backend for other tools
    python3 \
    pipx \
# Linter
    shellcheck \
# Other tools
    tree \
# Clean package manager
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
# LLVM dependencies
    lsb-release \
    wget \
    software-properties-common \
    gnupg \
# Clean package manager
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
# Install LLVM
    && wget -O /tmp/llvm.sh https://apt.llvm.org/llvm.sh \
    && bash /tmp/llvm.sh ${LLVM_VERSION} all \
    && ln -s /usr/bin/clang-${LLVM_VERSION} /usr/local/bin/clang \
    && ln -s /usr/bin/clang++-${LLVM_VERSION} /usr/local/bin/clang++ \
    && ln -s /usr/bin/clang-format-${LLVM_VERSION} /usr/local/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-${LLVM_VERSION} /usr/local/bin/clang-tidy \
    && ln -s /usr/bin/clangd-${LLVM_VERSION} /usr/local/bin/clangd \
    ;

RUN pipx --version \
# Build System
&& pipx install  cmake \
&& pipx install  cmakelang \

