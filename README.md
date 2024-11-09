# Dockerized Monero Node

A Dockerized Monero node setup for quickly deploying and running a Monero full node. This container includes the Monero daemon `monerod` to sync and maintain the Monero blockchain, with configuration options for persistence and port forwarding.
This configuration is optimized for a Raspberry Pi 5 4GB.

## Requirements (For `ARMv8`)

- Docker
- Docker Compose
- ~90 GB of free SSD or SD Card space

## Getting Started

### 1. Clone the Repository

Make sure to check the branches menu for additional CPU architectures.

```bash
git clone -b linux-ARMv8 https://github.com/toastedden/monero-node-docker.git
cd monero-node-docker
```

### 2. Configuration

The `bitmonero.conf` file in `./data` allows custom configuration of `monerod`. Adjust any settings as needed, such as RPC options, and ensure the `./data` folder exists for mounting.

### 3. Spin Up the Container

Run the following command to build and start the Monero node container:

```bash
docker compose up --build -d
```

The Monero node will begin syncing the blockchain. This may take some time depending on your network connection and system resources.

### 4. Accessing the Node

- **P2P Port**: `18080` - Used for communication with other nodes.
- **RPC Port**: `18081` - Allows remote procedure calls to interact with your node.

### 5. Data Persistence

The blockchain data is stored in `./data`, which is mounted to `/home/monero/data` in the container. The configuration file (`bitmonero.conf`) should also be placed in this directory. This allows data to persist between container restarts.

## Docker Compose Configuration

Here's an example of the `docker-compose.yaml` used:
```yaml
services:
  monero_node:
    container_name: monero_node
    environment:
      - PUID=1000
      - PGID=1000
    build:
      context: .
    ports:
      - "18080:18080/tcp"
      - "18081:18081/tcp"
    volumes:
      - ./data:/home/monero/data
    restart: unless-stopped
```

## Connect to your node

### 1. Ensure your ports are forwarded on the host

For Debain based systems, use `ufw`.
```bash
sudo ufw allow 18080/tcp && sudo ufw allow 18081/tcp
sudo ufw reload
```

### 2. Sync your wallet

Open you monero wallet of choice, and add a custom node.
- Set the IP as your hosts IP address: `<YOUR_HOSTS_IP_ADDRESS>`
- Set the port to `18081`
- Use `TLS` or `SSL` if the option is available.
- Mark as `Trusted Node` if the option is available.
- Wait for your wallet to sync.
