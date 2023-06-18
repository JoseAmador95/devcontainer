FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C
ENV PIPX_BIN_DIR=/usr/local/bin

RUN apt-get update && apt-get install -y --no-install-recommends \
# Tar engine
    xz-utils \
# C/C++ compiler & build tools
    ninja-build \
    clang \
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
# Code check
    clang-format \
    clang-tidy \
# Documentation generation
    doxygen \
    graphviz \
# Backend for other tools
    ruby ruby-dev gem \
    python3 \
    pipx \
# Linter
    shellcheck \
# Other tools
    tree \
# Clean package manager
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pipx --version \
# Build System
&& pipx install  cmake \
&& pipx install  cmakelang \
# Cyclomatic complpexity analysis
&& pipx install  lizard \
# Linter
&& pipx install  pylint \
# Formatter
&& pipx install  black \
# Type hint check
&& pipx install  mypy

RUN for package in ${PY_PACKAGES}; do pipx install ${package}; done

RUN gem install \
# Unit test framework
    ceedling

