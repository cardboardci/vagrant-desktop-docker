#!/bin/bash
start="$(date +%s)"
echo "Provisioning Desktop Environment"
echo "-----------------------------"

apt-get -y install --install-recommends lubuntu-desktop 

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in $(($end - $start)) seconds"