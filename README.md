# aptly

docker build -t aptly-docker .


docker run -d -p 8080:8080 --name aptly-container aptly-docker
