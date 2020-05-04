
#!/bin/bash -eux

## 
# Script for pushing images to systel repository
#
# Parameters :
# - version : Image version number to push
# - repository (optionnal) : A docker repository (default: ntdtfr)
# ./scripts/push.sh 1.0
# ./scripts/push.sh 1.0 ntdtfr

# Image version
version=$1
if test -z "$version"
then 
    echo "No version specified. Use version 1.0 as default value."
    version=1.0
fi

repository=$2
if test -z "$repository"
then 
    echo "No repository specified. Use ntdtfr as default value."
    repository=ntdtfr
fi

echo "===> Pushing image to ntdtfr repository..."
docker tag pic-viewer:$version $repository/pic-viewer:$version
docker push $repository/pic-viewer:$version
