#!/usr/bin/env sh

# there are other options other than run the node module directly
# but the docker multi-file-swagger cannot generate yaml output and
# cannot specify the output path
# another option is speccy, but it messes up the ref: "#/path"
root=${PWD}
# you have go to the path where the openapi file is. otherwise it cannot reference
# the reference files specified by $ref
cd ${root}/api-schema/doc

multi-file-swagger -o yaml openapi.yaml > ${root}/api-schema/build/openapi.yaml