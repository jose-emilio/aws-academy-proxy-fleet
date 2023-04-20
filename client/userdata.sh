#!/bin/bash
service-endpoint=<punto-enlace>
export http_proxy=http://<punto-enlace>:3128
export https_proxy=http://<punto-enlace>:3128
echo "http_proxy=http://<punto-enlace>:3128" >> /etc/environment
echo "https_proxy=http://<punto-enlace>:3128" >> /etc/environment
mkdir -p /etc/systemd/system/amazon-ssm-agent.service.d
cat <<EOF >/etc/systemd/system/amazon-ssm-agent.service.d/override.conf
[Service]
Environment="http_proxy=http://<punto-enlace>:3128"
Environment="https_proxy=http://<punto-enlace>:3128"
Environment="no_proxy=169.254.169.254"
EOF
sudo systemctl daemon-reload
systemctl restart amazon-ssm-agent
yum update -y
yum install lynx -y
