#!/bin/sh

echo "Image: $1"
echo "Container Name: $2"
echo "Record Path: $3"

pathMapping="$3:/rtmp_records"
echo "Path mapping: $pathMapping"

docker run \
  -it \
  -d \
  --rm \
  --name $2 \
  -p 127.0.0.1:11935:11935 \
  -p 127.0.0.1:11936:11936 \
  -v $pathMapping \
  $1
