#!/bin/bash
docker build -t elastic .
docker exec -ti $(docker run \
-d \
--rm \
-h elastic \
--privileged \
-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-p 9200:9200 \
-i -t elastic  /usr/sbin/init \
) /bin/bash