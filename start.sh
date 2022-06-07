#!/bin/sh
BASE_DIR=$(pwd)

cd $BASE_DIR/terraform

terraform init
terraform apply -auto-approve

export PROXY_USER=$(openssl rand -base64 32)
export PROXY_PASSWORD=$(openssl rand -base64 32)
export PROXY_IP=$(terraform output -json | jq '.proxy_public_ips.value[0]' | tr -d \")

sleep 20

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i generated/proxy.ini ../ansible/proxy.yaml

cd $BASE_DIR

echo "Edit the file /etc/proxychains4.conf with:"
echo "http  $PROXY_IP 26893 $PROXY_USER $PROXY_PASSWORD"
