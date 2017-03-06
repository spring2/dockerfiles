$build="0.5.5-rc2"
docker build -t spring2/nomad:$build .
docker tag spring2/nomad:$build spring2/nomad:latest

docker push spring2/nomad:$build
docker push spring2/nomad:latest
