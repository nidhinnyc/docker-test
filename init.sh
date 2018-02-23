#!/bin/bash
echo " => Starting container"
docker exec -ti $(docker run \
-d \
--rm \
-h dbdocker \
--privileged \
-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-i -t ol7dbus  /usr/sbin/init \
) /bin/bash
