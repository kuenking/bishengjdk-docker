#!/usr/bin/env bash
set -o pipefail

FILE_SITE=https://mirror.iscas.ac.cn/kunpeng/archive/compiler/bisheng_jdk/
DOCKER_IMAGE_PREFIX=wang1010q/bishengjdk
# github action use ubuntu vm, grep -P success
jdk_versions=`curl -s $FILE_SITE | grep -o -P "jdk-(.*?)-" | awk '{sub(/.{1}$/,"")}1' |awk '{print substr($1,5)}' |sort -u`

for version in $jdk_versions
do
  image_name=$DOCKER_IMAGE_PREFIX:$version
  echo "INFO: Checking when the bishengjdk docker image ${image_name} was built ..."

  if ! docker pull "${image_name}" &>/dev/null; then
    echo "INFO: bishengjdk docker image for ${image_name} does not exist. Docker build needed"
    docker buildx build --build-arg JAVA_VERSION=$version --platform linux/arm64 -t ${image_name} . --push
  fi
done