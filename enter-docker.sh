#!/usr/bin/env bash
# enter-docker.sh
# Çalıştırıldığında container çalışıyorsa dev kullanıcısı ile bağlanır, yoksa uyarı verir

CONTAINER_NAME="dev"
USER_NAME="dev"

# Check container is running
if [ "$(docker ps -q -f name=^/${CONTAINER_NAME}$)" = "" ]; then
    echo "Container ${CONTAINER_NAME} çalışmıyor. Başlatmak için:"
    echo "docker run -d --name ${CONTAINER_NAME} -v \$PWD/output:/mnt/output debian-dev:latest sleep infinity"
    exit 1
fi

# Container çalışıyor, bağlan
docker exec -it -u ${USER_NAME} ${CONTAINER_NAME} bash

