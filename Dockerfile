FROM ubuntu:rolling

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

RUN apt-get update && apt-get install -y --no-install-recommends \
# Tar engine
    xz-utils \
# C/C++ compiler & build tools
    build-essential \
    ninja-build \
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
    python3-pip \
# Linter
    shellcheck \
# Other tools
    tree \
# Clean package manager
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN python3 -m pipx install \
# Build System
    cmake \
    cmakelang \
# Cyclomatic complpexity analysis
    lizard \
# Linter
    pylint \
# Formatter
    black \
# Type hint check
    mypy

RUN gem install \
# Unit test framework
    ceedling
