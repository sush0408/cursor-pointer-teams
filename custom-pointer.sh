#!/bin/bash
echo "This scripts Creates a pointer which follows you mouse"
echo "./custom-pointer.sh start  - to start cursor pointer"
echo "./custom-pointer.sh stop  - to stop cursor pointer"

start_pointer() {
    docker run --rm --detach --name=cursor-pointer \
    --user="${UID}" --env "DISPLAY=${DISPLAY}" \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
    sush0408/cursor-pointer \
    find-cursor \
        --repeat 0 --follow --distance 1 --wait 120 \
        --line-width 16 --size 16 --color red
        \
    
    echo "A docker container is being created with name cursor-pointer"
}

stop_pointer() {
    echo "Please Wait ..."
    docker stop cursor-pointer
}

isDockerActive=$(systemctl is-active docker);
if [ $isDockerActive == "active" ];
then
    if [ $1 == "start" ]; 
    then
        start_pointer
    elif [ $1 == "stop" ]; 
    then
        stop_pointer
    else
        start_pointer
    fi
else
    echo "Docker Deamon Not Running"
fi
