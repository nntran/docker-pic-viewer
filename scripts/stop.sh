
#!/bin/bash -eux

## 
# Script for stopping all services
#
# ./scripts/stop.sh

echo "===> Stopping services..."

# 
#docker-compose stop
docker-compose down --volumes --remove-orphans --rmi local
#docker-compose rm -sfv

