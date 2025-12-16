docker pull nginx:mainline-alpine3.23-perl

docker build -t nginx:mainline-alpine3.23-perl .

docker run -d -p 80:80 nginx:mainline-alpine3.23-perl