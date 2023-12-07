# aptly
# To build
docker build -t custom-aptly .

# To run
docker run -d -p 8080:8080 --name custom-aptly custom-aptly
