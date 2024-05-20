#!/usr/bin/env bash

IMAGE_NAME=docker.io/joseamador95/devcontainer
IMAGE_TAG=${1:-"main"}

podman run --rm --interactive --tty "${IMAGE_NAME}":"${IMAGE_TAG}"
