# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "agent1" do |agent1|
    agent1.vm.box = "ubuntu/trusty64"
    agent1.vm.hostname = 'agent1'
    agent1.vm.box_url = "ubuntu/trusty64"

    config.vm.provision :shell, :path => 'bootstrap.sh', :args => ["/vagrant/agent1/config.json"]

    agent1.vm.network :private_network, ip: "172.20.20.10"
    agent1.vm.network :forwarded_port, guest: 22, host: 4322, id: "ssh"


    agent1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "agent1"]
    end
  end

  
  config.vm.define "agent2" do |agent2|
    agent2.vm.box = "ubuntu/trusty64"
    agent2.vm.hostname = 'agent2'
    agent2.vm.box_url = "ubuntu/trusty64"

    config.vm.provision :shell, :path => 'bootstrap.sh', :args => ["/vagrant/agent2/config.json"]

    agent2.vm.network :private_network, ip: "172.20.20.20"
    agent2.vm.network :forwarded_port, guest: 22, host: 4323, id: "ssh"


    agent1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "agent2"]
    end
  end
  


  config.vm.define "agent3" do |agent3|
    agent3.vm.box = "ubuntu/trusty64"
    agent3.vm.hostname = 'agent3'
    agent3.vm.box_url = "ubuntu/trusty64"

    config.vm.provision :shell, :path => 'bootstrap.sh', :args => ["/vagrant/agent3/config.json"]

    agent3.vm.network :private_network, ip: "172.20.20.30"
    agent3.vm.network :forwarded_port, guest: 22, host: 4324, id: "ssh"


    agent1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "agent3"]
    end
  end  


  config.vm.define "webuiportal" do |webuiportal|
    webuiportal.vm.box = "ubuntu/trusty64"
    webuiportal.vm.hostname = 'webuiportal'
    webuiportal.vm.box_url = "ubuntu/precise64"

    config.vm.provision :shell, :path => 'webuiportal.sh', :args => ["/vagrant/webuiportal/config.json"]

    webuiportal.vm.network :private_network, ip: "172.20.20.40"
    webuiportal.vm.network :forwarded_port, guest: 22, host: 4325, id: "ssh"

    webuiportal.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "webuiportal"]
    end
  end

end
