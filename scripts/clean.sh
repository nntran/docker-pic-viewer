
#!/bin/bash -eux

## 
# Clean script
# 
# Parameter :
# - version (optional) : Remove options (all: remove all build images; version: remove only a version number)
# ./scripts/clean.sh all
# ./scripts/clean.sh 1.0
# ./scripts/clean.sh

version=$1
image_name=pic-viewer

# if [ $# = 0 ]
# then
#     echo "No version specified. Use version 1.0 as default value."
#     version=1.0
# fi

# or

# if test -z "$version"
# then 
#     echo "No version specified. Use version 1.0 as default value."
#     version=1.0
# fi

echo "===> Remove all orphan images..."
images=`docker images --filter 'dangling=true' -q --no-trunc`
#echo "Images: $images"
if test -z "$images"
then 
    echo "===> No orphan images found!"
else 
    docker rmi -f $(docker images --filter 'dangling=true' -q --no-trunc)
fi

if test -n "$version"; then 
    # A version is passed
    if [[ "$version" == all ]]; then
        echo "===> Remove all containers using image $image_name..."
        # Check running and stoping containers
        containers=`docker ps -a | grep $image_name`
        if test -z "$containers"
        then 
            echo "===> No container detected!"
        else
            docker-compose down --volumes --remove-orphans --rmi local
            docker-compose rm -sfv
            docker rm -vf $(docker ps -a | grep $image_name | awk '{print $1}')
        fi

        echo "===> Remove all $image_name images..." 

        images=`docker image ls | grep $image_name | awk '{print $3}'`
        if test -z "$images"
        then 
            echo "===> No image found!"
        else 
            docker rmi -f $(docker image ls | grep $image_name | awk '{print $3}')
        fi
    else
        echo "===> Remove containers using image tag $image_name:$version..."
            
        # Check running and stoping containers
        containers=`docker ps -a | grep $image_name | grep $version`
        if test -z "$containers"
        then 
            echo "===> No container detected!"
        else
            docker-compose down --volumes --remove-orphans --rmi local
            docker-compose rm -sfv
            docker rm -vf $(docker ps -a | grep $image_name | grep $version | awk '{print $1}')
        fi

        echo "===> Remove images with tag $image_name:$version..."

        images=`docker image ls | grep $image_name | grep $version | awk '{print $3}'`
        if test -z "$images"
        then 
            echo "===> No image with tag $image_name:$version found!"
        else 
            docker rmi -f $(docker image ls | grep $image_name | grep $version | awk '{print $3}')
        fi
    fi
fi