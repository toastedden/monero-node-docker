# Use Debian as a base image
FROM debian:latest

# Set the working directory to the home directory
WORKDIR /home

# Create the monero directory
RUN mkdir -p /home/monero

# Install curl, tar, and bzip2 (necessary for downloading and extracting Monero)
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    bzip2

# Download Monero CLI for x86_64
RUN curl -L -o monero-cli.tar https://downloads.getmonero.org/cli/linux64

# Extract the Monero CLI tar file and move its contents to the monero directory
RUN tar --strip-components=1 -xvf monero-cli.tar -C /home/monero

# Make monerod and all other files in /home/monero executable
RUN chmod +x /home/monero/*

# Copy configuration file
COPY bitmonero.conf /home/monero/data/bitmonero.conf

# Set the user and permissions if necessary
# RUN chown -R monero:monero /home/monero

# Set monerod to run on container startup, while using bitmonero.conf as the config file.
CMD ["/home/monero/monerod", "--config=/home/monero/data/bitmonero.conf", "--non-interactive"]