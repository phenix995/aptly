# Use a base Ubuntu image
FROM ubuntu:latest

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y wget gnupg software-properties-common nginx

# Install Aptly and clean up
RUN wget -O - https://www.aptly.info/pubkey.txt | apt-key add - && \
    echo "deb http://repo.aptly.info/ squeeze main" > /etc/apt/sources.list.d/aptly.list && \
    apt-get update && \
    apt-get install -y aptly \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for Aptly configuration
RUN mkdir -p /var/aptly && \
    chmod -R 777 /var/aptly

# Set the working directory
WORKDIR /var/aptly

# Copy your Aptly configuration file
COPY aptly.conf /etc/aptly.conf

# Initialize and configure Nginx to serve your repository
RUN rm -f /etc/nginx/sites-enabled/default && \
    echo "server { listen 80 default_server; location / { root /var/aptly/public; autoindex on; } }" > /etc/nginx/conf.d/default.conf

# Expose Aptly's default HTTP port (for API and publishing)
EXPOSE 8080:8080

# Start Nginx and keep the container running
CMD service nginx start && tail -f /var/log/nginx/access.log
