# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.hostname = "spreebox"

  # port forwarding by service
  config.vm.network "forwarded_port", guest: 9200, host: 9200   # elasticsearch
  config.vm.network "forwarded_port", guest: 3000, host: 3000   # rails app
  config.vm.network "forwarded_port", guest: 5432, host: 5432   # postgres
  config.vm.network "forwarded_port", guest: 6379, host: 6379   # redis

  config.vm.provider "virtualbox" do |vb|
    vb.name = "vb-sprangularbox"
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--vram", "128"]
  end

  config.omnibus.chef_version = "12.9.41"
  config.berkshelf.enabled = true

  config.vm.synced_folder "./spreeapp", "/spreeapp", type: 'nfs'

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "git"
    chef.add_recipe "java"
    chef.add_recipe "rvm::system"
    chef.add_recipe "nodejs"
    chef.add_recipe 'redisio'
    chef.add_recipe 'redisio::enable'

    # custom cookbooks
    chef.add_recipe "spreebox-elasticsearch"
    chef.add_recipe "spreebox-postgresql"

    chef.json = {
      localegen: {
        lang: [ "en_US.UTF8" ]
      },
      java: {
        install_flavor: "oracle",
        jdk_version: "8",
        oracle: {
          accept_oracle_download_terms: true
        }
      },
      rvm: {
        group_users: ["vagrant"],
        default_ruby: "2.4.0",
        global_gems: [
          { name: "bundler" }
        ]
      },
      nodejs: {
        install_method: "binary",
        version: "6.9.1",
        binary: {
          checksum: "d4eb161e4715e11bbef816a6c577974271e2bddae9cf008744627676ff00036a"
        }
      },
      postgresql: {
        pg_hba: [
          {type: 'local', db: 'all', user: 'postgres', addr: nil,            method: 'trust'},
          {type: 'local', db: 'all', user: 'all',      addr: nil,            method: 'trust'},
          {type: 'host',  db: 'all', user: 'all',      addr: '127.0.0.1/32', method: 'trust'},
          {type: 'host',  db: 'all', user: 'all',      addr: '::1/128',      method: 'trust'}
        ],
        initdb_locale: 'en_US.UTF8',
        password: {
          postgres: 'postgres',
          vagrant: 'vagrant'
        }
      }
    }
  end
end
