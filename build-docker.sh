#!/bin/sh

docker build . --build-arg HTTP_PROXY=http://172.17.218.224:17890 --build-arg HTTPS_PROXY=http://172.17.218.224:17890 -t nginx-test:0.1
