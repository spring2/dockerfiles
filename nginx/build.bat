docker build -t spring2/nginx:latest -f Dockerfile .
docker tag spring2/nginx:latest spring2/nginx:1.13.0

docker build -t spring2/nginx:latest-nanoserver -f Dockerfile.nanoserver .
docker tag spring2/nginx:latest-nanoserver spring2/nginx:1.11.13-nanoserver
