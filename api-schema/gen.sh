#!/usr/bin/env bash
docker run --rm -v ${PWD}:/local \
    -v ${PWD}/doc:/local/doc \
    -v ${PWD}/src/generated/java:/local/out/src/main/java \
    openapitools/openapi-generator-cli generate \
    -i /local/doc/openapi.yaml \
    -g spring \
    -o /local/out \
    --additional-properties useTags=true \
    --additional-properties interfaceOnly=true \
    --additional-properties dateLibrary=java8 \
    --model-package com.dou.dou.appService.model \
    --api-package com.dou.dou.controller
