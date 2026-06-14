# 1. Update & install deps
    apt-get update -y
    apt-get install -y \
      ca-certificates \
      curl \
      gnupg \
      lsb-release

    # 2. Add Docker's official GPG key
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
      | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    # 3. Add Docker apt repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" \
      | tee /etc/apt/sources.list.d/docker.list > /dev/null

    # 4. Install Docker Engine + Compose plugin
    apt-get update -y
    apt-get install -y --fix-missing \
      docker-ce \
      docker-ce-cli \
      containerd.io \
      docker-buildx-plugin \
      docker-compose-plugin

    # 5. Symlink so both `docker-compose` and `docker compose` work
    ln -sf /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose

    # 6. Add vagrant user to docker group
    usermod -aG docker vagrant

    # 7. Enable & start Docker
    systemctl enable docker
    systemctl start docker

    echo "Docker $(docker --version) installed successfully."
    echo "Docker Compose $(docker compose version) installed successfully."