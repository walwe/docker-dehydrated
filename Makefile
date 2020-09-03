NAMESPACE=walwe/dehydrated
DOCKER_REGISTRY=docker.io
.RECIPEPREFIX != ps

PLATFORM=$(shell uname -m)
VERSION=$(shell git rev-parse --short HEAD)
DOCKER_FILE=Dockerfile

default: build

build:
    docker build --tag ${DOCKER_REGISTRY}/${NAMESPACE}:${VERSION} -f ${DOCKER_FILE} .

build-latest:
    docker build --tag ${DOCKER_REGISTRY}/${NAMESPACE}:latest -f ${DOCKER_FILE} .

force-build:
    docker build --no-cache --tag ${DOCKER_REGISTRY}/${NAMESPACE}:${VERSION} -f ${DOCKER_FILE} .

push:
    docker push ${DOCKER_REGISTRY}/${NAMESPACE}:${VERSION}
    
push-latest:
    docker tag ${DOCKER_REGISTRY}/${NAMESPACE}:${VERSION} ${DOCKER_REGISTRY}/${NAMESPACE}:latest
    docker push ${DOCKER_REGISTRY}/${NAMESPACE}:latest

run:
    docker run --name ${NAMESPACE} -ti ${DOCKER_REGISTRY}/${NAMESPACE}:${VERSION}

clean:
    docker rm ${NAMESPACE}

.PHONY: all push force-build
