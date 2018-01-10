# Confined container with HW resources, connectivity and RO filesystem
CONTAINER_FLAGS="--net=none --cpu-period=50000 --cpu-quota=25000 --read-only --cpu-shares 256 --restart=always  --cpuset-mems 0 --cpuset-cpus 0"
