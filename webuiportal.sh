#!/bin/bash

# Step 1 - Get the necessary utilities and install them.
apt-get update
apt-get install -y unzip

# Step 2 - Copy the upstart script to the /etc/init folder.
cp /vagrant/webuiportal/consul.conf /etc/init/consul.conf

# Step 3 - Get the Consul Zip file and extract it.  

cp /vagrant/bin/consul_0.7.2_linux_amd64.zip /usr/local/bin/.
cd /usr/local/bin
chmod -R 775 consul_0.7.2_linux_amd64.zip
unzip -o consul_0.7.2_linux_amd64.zip -d /usr/local/bin
rm -rf *.zip

# step 4 - Get the Consul UI
cp /vagrant/bin/consul_0.7.2_web_ui.zip /usr/local/bin/. 
cd /usr/local/bin/
chmod -R 775 consul_0.7.2_web_ui.zip
unzip -o consul_0.7.2_web_ui.zip -d /usr/local/bin
rm -rf *.zip

# Step 5 - Make the Consul directory.
mkdir -p /etc/consul.d
mkdir -p /var/consul

# Step 6 - Copy the server configuration.
cp $1 /etc/consul.d/config.json

# Step 7 - Start Consul
exec consul agent -ui -config-file=/etc/consul.d/config.json &
