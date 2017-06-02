#!/bin/bash
start="$(date +%s)"

echo "Provisioning Environment"
echo "-----------------------------"
echo "Installing keys..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
echo "-----------------------------"
echo "Installing libraries..."
apt-get -y update
apt-get -y install docker-ce
groupadd docker
usermod -aG docker vagrant
docker run --rm hello-world

echo "-----------------------------"
echo "Installing software..."
echo "No software to install."

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in "$(expr $end - $start)" seconds"