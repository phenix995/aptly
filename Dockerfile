# Use a base Debian image
FROM debian:stable-slim

# Install required packages
RUN apt-get update && \
    apt-get install -y aptly && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for Aptly configuration
RUN mkdir -p /var/aptly && \
    chmod -R 777 /var/aptly

# Set the working directory
WORKDIR /var/aptly

# Expose Aptly's default HTTP port (for API and publishing)
EXPOSE 8080

# Specify the command to run when the container starts
CMD ["aptly"]
