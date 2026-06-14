#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update

echo "==> Installing NGINX..."
apt-get install -y nginx

echo "==> start NGINX..."
systemctl enable nginx
systemctl start nginx

echo " ==> install python venv package ..."
apt install -y python3-venv

echo "==> clone repository and setup virtual environment..."
# Run as vagrant (not root) so all project files are owned by the app service user
sudo -u vagrant git clone https://github.com/Afeez1131/fastapi-demo.git
cd /home/vagrant/fastapi-demo
sudo -u vagrant python3 -m venv .venv
sudo -u vagrant .venv/bin/pip install -r requirements.txt
# Copy example env so the real .env (which holds secrets) is never committed to the repo
sudo -u vagrant cp .env.example .env

# Inject the DB and Redis URLs using hostnames (resolved via vagrant-hostmanager)
# rather than IPs, so the config stays valid if IPs change
sed -i "s|^DATABASE_URL=.*|DATABASE_URL=postgresql+asyncpg://${DB_USER}:${DB_PASS}@fdb01:5432/${DB_NAME}|" .env
sed -i "s|^REDIS_URL=.*|REDIS_URL=redis://rd01:6379/0|" .env

echo "==> Service setup..."
cat <<EOF > /etc/systemd/system/fastapi-demo.service
[Unit]
Description=FastAPI Demo App
After=network.target

[Service]
User=vagrant
Group=vagrant
WorkingDirectory=/home/vagrant/fastapi-demo
Environment="PATH=/home/vagrant/fastapi-demo/.venv/bin"
EnvironmentFile=/home/vagrant/fastapi-demo/.env
# --host 0.0.0.0 is required so Nginx can reach uvicorn from localhost;
# without it uvicorn only binds 127.0.0.1 and the proxy_pass would fail
ExecStart=/home/vagrant/fastapi-demo/.venv/bin/uvicorn app.main:app --host 0.0.0.0 --port 8000
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

echo "==> Starting FastAPI service..."
systemctl daemon-reload
systemctl enable fastapi-demo
systemctl start fastapi-demo

echo "==> Configuring NGINX as reverse proxy..."
rm -f /etc/nginx/sites-enabled/default

cat <<'EOF' > /etc/nginx/sites-available/fastapi-demo
server {
    listen 80;
    server_name ngx01;

    access_log /var/log/nginx/fastapi-demo.access.log;
    error_log /var/log/nginx/fastapi-demo.error.log;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

ln -s /etc/nginx/sites-available/fastapi-demo /etc/nginx/sites-enabled/
# nginx -t validates config syntax before applying; reload is graceful (no dropped connections)
nginx -t && systemctl reload nginx

echo "==> Done. App is ready."