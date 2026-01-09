# Image URL to use for building/pushing images
TAG ?= latest
IMG ?= docker.io/klines/gitops:${TAG}

# Build the docker image
docker-build:
	podman build . -t ${IMG}

# Push the docker image
docker-push:
	podman push ${IMG}
