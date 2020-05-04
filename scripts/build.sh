
#!/bin/bash -eux

## 
# Build script
# 
# Parameters :
# - version : Version number to build
#
# ./script/build.sh 1.0 

# Docker (image) version
version=$1
if test -z "$version"
then 
    echo "No version specified. Use version 1.0 as default value."
    version=1.0
fi

# Export variable for docker-compose script
export VERSION=$version

echo "===> Prepare to build image for the version $version"
sh ./scripts/clean.sh $version

echo "===> Build with docker-compose..."
docker-compose build --compress --force-rm --parallel --build-arg version=$version
sh ./scripts/clean.sh
