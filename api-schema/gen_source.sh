#!/usr/bin/env sh

action=$1

exe_path="`dirname \"$0\"`"

generate_classes(){
  cd ${exe_path}
  docker run --rm \
      -v ${PWD}/build:/local/doc \
      -v ${PWD}/src/generated/java:/local/out/src/main/java \
      openapitools/openapi-generator-cli:v3.3.4 generate \
      -i /local/doc/openapi.yaml \
      -g spring \
      -o /local/out \
      --additional-properties useTags=true \
      --additional-properties interfaceOnly=true \
      --additional-properties dateLibrary=java8 \
      --model-package com.dou.dou.appService.model \
      --api-package com.dou.dou.controller
}


generate_docs(){
  docker run --rm \
    -v ${PWD}/build:/local/doc \
    -v ${PWD}/gen_docs:/local/gen_docs \
    openapitools/openapi-generator-cli:v3.3.4 generate \
    -i /local/doc/openapi.yaml \
    -o /local/gen_docs \
    -g html
}

case "$action" in
  doc)
    generate_docs
  ;;
  class)
    generate_classes
  ;;
esac

