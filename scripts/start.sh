
#!/bin/bash -eux

## 
# Script for starting all services
#
# ./scripts/start.sh 1.0

# Application (image) version
version=$1
if test -z "$version"
then 
    echo "===> No version specified. Use version 1.0 as default value."
    version=1.0
fi

# Export variable for docker-compose script
export VERSION=$version

# Check no services are already running
ps=`docker ps | grep pic-viewer | grep $version`
if test -z "$ps"
then 
    echo "===> Starting services with version $version..."
    docker-compose up -d
    docker-compose logs -f
else
    echo "===> Running services detected!"
fi
