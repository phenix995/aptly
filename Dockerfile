# Base on: https://github.com/urpylka/docker-aptly/blob/master/

# Use a base Ubuntu image
FROM ubuntu:latest

# Set apt cacher proxy if needed
#RUN echo 'Acquire::http::Proxy "http://172.17.0.2:3142";' > /etc/apt/apt.conf.d/01proxy

# Update and install necessary packages
RUN apt update && apt -q update \
  && apt-get -y install \
    bzip2 \
    gnupg2 \
    gpgv \
    graphviz \
    supervisor \
    nginx \
    curl \
    xz-utils \
    apt-utils \
    gettext-base \
    bash-completion \
    nano \
    gnupg
RUN apt clean \
  && rm -rf /var/lib/apt/lists/*

# Copy aptly config file
COPY aptly.conf /etc/aptly.conf
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY supervisord.web.conf /etc/supervisor/conf.d/web.conf

# Set volume for aptly data
VOLUME apt-data:/opt/aptly

# Expose aptly port
EXPOSE 80 8080

# Set aptly as entrypoint
ENTRYPOINT ["/usr/bin/aptly"]

# Set aptly as default command
CMD ["api", "serve"]
