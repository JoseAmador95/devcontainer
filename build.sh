#!/usr/bin/env bash

ROOT_DIR=$(dirname "$0")
IMAGE_NAME=joseamador95/devcontainer
IMAGE_TAG=${1:-"main"}
podman build -t "${IMAGE_NAME}":"${IMAGE_TAG}" "${ROOT_DIR}"
