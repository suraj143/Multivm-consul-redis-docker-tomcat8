#!/bin/bash

# Step 1 - Install utilities unzip . 
apt-get update
apt-get install -y unzip

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

# Step 2 - Copy the upstart script to the /etc/init folder.
cp /vagrant/conf/consul.conf /etc/init/consul.conf

# Step 3 - Get the Consul Zip file and extract it.  
cp /vagrant/bin/consul_0.7.2_linux_amd64.zip /usr/local/bin/.
cd /usr/local/bin
chmod -R 775 consul_0.7.2_linux_amd64.zip
unzip -o consul_0.7.2_linux_amd64.zip -d /usr/local/bin
rm *.zip

# Step 4 - Make the Consul directory.
mkdir -p /etc/consul.d
mkdir -p /var/consul

# Step 5 - Copy the server configuration.
cp $1 /etc/consul.d/config.json

# Step 6 - Start Cconsul
exec consul agent -config-file=/etc/consul.d/config.json &

### Installing Redis starts here  ###
	echo "Fetching Redis - latest version"
	
	mkdir /opt/redis
	cd /opt/redis
	wget -q http://download.redis.io/redis-stable.tar.gz
	tar -xz --keep-newer-files -f redis-stable.tar.gz
	cd redis-stable
	chmod -R 777 *
	
	make
	exec src/redis-server &

### Installing docker starts here ###

	sudo apt-get install apt-transport-https \
                       ca-certificates
    curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
    apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
    sudo add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"
       
    sudo apt-get update
    sudo apt-get -y install docker-engine
    
    sudo su -
    cd /
    chmod -R 777 *

    cp -R /vagrant/dockerfiles /tmp
	chmod -R 777 /tmp/dockerfiles
    cd /tmp/dockerfiles
    docker build -t ncrfirstimage .
    docker ps -a
    docker run -d --name ncrfirstcontainer -p 8080:8080 ncrfirstimage
    docker ps -a
