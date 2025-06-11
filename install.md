# Install Docker

## Window

### 安裝 WSL 2

### 安裝 Docker Desktop

## MacOs

### 安裝 Intel Docker Desktop

### 安裝 Apple Silicon Docker Desktop

## Kali

### Kali 安裝 Docker

``` bash
sudo rm -f /etc/apt/trusted.gpg.d/kali-archive-keyring.gpg
sudo wget -qO - https://archive.kali.org/archive-key.asc | sudo tee /etc/apt/trusted.gpg.d/kali-archive-keyring.asc 
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker --now
```

### 加入 dcoker 權限

``` bash
sudo usermod -aG docker $USER
newgrp docker
```




### 執行 dcoker
``` bash
docker images
docker ps -a
docker search hello
docker run --rm hello-world # (加上—rm為執行後即刪除)
```

### 安裝 Docker Compose

``` bash
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

### 加入 docker-compose 權限

``` bash
sudo chmod +x /usr/local/bin/docker-compose
```

### 啟動 docker-compose
到指定 docker-compose.yml 位置
``` bash
COMPOSE_BAKE=true docker-compose up -d
```

### kai 掛上 vmware share folder
``` bash
sudo vmhgfs-fuse .host:/ /media -o allow_other
```
