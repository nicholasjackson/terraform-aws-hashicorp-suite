#!/bin/bash
set -e

echo "Grabbing IPs..."
PRIVATE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

function installDependencies() {
  echo "Installing dependencies..."
  sudo apt-get -qq update &>/dev/null
  sudo apt-get -yqq install unzip &>/dev/null
}

function installDocker() {
  echo "Installing Docker..."
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
  sudo apt-get update
  sudo apt-get install -y docker-engine
}

function installConsul() {
  echo "Fetching Consul..."
  cd /tmp
  curl -sLo consul.zip https://releases.hashicorp.com/consul/$1/consul_$1_linux_amd64.zip
  
  echo "Installing Consul..."
  unzip consul.zip >/dev/null
  sudo chmod +x consul
  sudo mv consul /usr/local/bin/consul
  
  # Setup Consul
  sudo mkdir -p /mnt/consul
  sudo mkdir -p /etc/consul.d
  sudo tee /etc/consul.d/config.hcl > /dev/null <<EOF
  ${consul_config}
EOF
  
  sudo tee /etc/systemd/system/consul.service > /dev/null <<"EOF"
  [Unit]
  Description = "Consul"
  
  [Service]
  # Stop consul will not mark node as failed but left
  KillSignal=INT
  ExecStart=/usr/local/bin/consul agent -config-dir="/etc/consul.d"
  Restart=always
  ExecStopPost=sleep 5
EOF
}


function installNomad() {
  echo "Fetching Nomad..."
  cd /tmp
  curl -sLo nomad.zip https://releases.hashicorp.com/nomad/${nomad_version}/nomad_${nomad_version}_linux_amd64.zip
  
  echo "Installing Nomad..."
  unzip nomad.zip >/dev/null
  sudo chmod +x nomad
  sudo mv nomad /usr/local/bin/nomad
  
  # Setup Nomad
  sudo mkdir -p /mnt/nomad
  sudo mkdir -p /etc/nomad.d
  sudo tee /etc/nomad.d/config.hcl > /dev/null <<EOF
  ${nomad_config}
EOF
  
  sudo tee /etc/systemd/system/nomad.service > /dev/null <<"EOF"
  [Unit]
  Description = "Nomad"
  
  [Service]
  # Stop consul will not mark node as failed but left
  KillSignal=INT
  ExecStart=/usr/local/bin/nomad agent -config="/etc/nomad.d"
  Restart=always
  ExecStopPost=sleep 5
EOF
}

function installVault() {
  echo "Fetching Vault..."
  cd /tmp
  curl -sLo vault.zip https://releases.hashicorp.com/vault/${vault_version}/vault_${vault_version}_linux_amd64.zip
  
  echo "Installing Vault..."
  unzip vault.zip >/dev/null
  sudo chmod +x vault
  sudo mv vault /usr/local/bin/vault
  
  # Setup Vault
  sudo mkdir -p /mnt/vault
  sudo mkdir -p /etc/vault.d
  sudo tee /etc/vault.d/config.hcl > /dev/null <<EOF
  ${vault_config}
EOF
  
  sudo tee /etc/systemd/system/vault.service > /dev/null <<"EOF"
  [Unit]
  Description = "Vault"
  
  [Service]
  KillSignal=INT
  ExecStart=/usr/local/bin/vault server -config="/etc/vault.d"
  Restart=always
EOF
}

# Install software
installDependencies

if [[ ${consul_enabled} == 1 ]]; then
  installConsul ${consul_version}
fi

if [[ ${nomad_enabled} == 1 ]]; then
  installNomad ${nomad_version}
fi

if [[ ${vault_enabled} == 1 ]]; then
  installVault ${vault_version}
fi

if [[ ${nomad_enabled} == 1 && ${nomad_type} == "client" ]]; then
  installDocker
fi


# Start services
sudo systemctl daemon-reload
  
if [[ ${consul_enabled} == 1 ]]; then
  sudo systemctl enable consul.service
  sudo systemctl start consul.service
fi

if [[ ${vault_enabled} == 1 ]]; then
  sudo systemctl enable vault.service
  sudo systemctl start vault.service
fi

if [[ ${nomad_enabled} == 1 ]]; then
  sudo systemctl enable nomad.service
  sudo systemctl start nomad.service
fi
