FROM ubuntu:jammy

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

RUN apt-get update && apt-get install -y --no-install-recommends \
# Tar engine
    xz-utils \
#C/C++ compiler & build tools
    build-essential \
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

RUN python3 -m pip install \
# Build System
    cmake \
# Cyclomatic complpexity analysis
    lizard \
# Linter
    pylint \
# Formatter
    black \
# Dependencies
    jinja2

# ARM GCC Compiler
ARG TOOLCHAIN_NAME=gcc-arm-11.2-2022.02-x86_64-arm-none-eabi
ARG ARM_NONE_EABI_LINK=https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/11.2-2022.02/binrel/${TOOLCHAIN_NAME}.tar.xz
ARG TOOLCHAIN_DOWNLOAD_DIR=/tmp
ADD ${ARM_NONE_EABI_LINK} ${TOOLCHAIN_DOWNLOAD_DIR}
RUN tar xf ${TOOLCHAIN_DOWNLOAD_DIR}/${TOOLCHAIN_NAME}.tar.xz -C ${TOOLCHAIN_DOWNLOAD_DIR} --checkpoint=.10000
RUN rm ${TOOLCHAIN_DOWNLOAD_DIR}/${TOOLCHAIN_NAME}.tar.xz
RUN cp -r ${TOOLCHAIN_DOWNLOAD_DIR}/${TOOLCHAIN_NAME}/lib/* /lib/
RUN cp -r ${TOOLCHAIN_DOWNLOAD_DIR}/${TOOLCHAIN_NAME}/bin/* /bin/
RUN arm-none-eabi-gcc --version

# Unit test framework
RUN gem install ceedling
