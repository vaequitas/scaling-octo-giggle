# -*- mode: ruby -*-
# vi: set ft=ruby :

servers = [
  {
    :hostname => 'vag-app-01',
    :ip => '192.168.33.21',
    :box => 'centos/7',
    :synced_folders => [
      {
        :host => '../app',
        :guest => '/var/sites/app',
      },
    ],
  },
  {
    :hostname => 'vag-app-02',
    :ip => '192.168.33.22',
    :box => 'centos/7',
    :synced_folders => [
      {
        :host => '../app',
        :guest => '/var/sites/app',
      },
    ],
  },
  {
    :hostname => 'vag-web-01',
    :ip => '192.168.33.11',
    :box => 'centos/7',
  },
]

Vagrant.configure("2") do |config|
  config.vm.provision :shell, path: "bootstrap.sh"

  servers.each do |server|
    config.vm.define server[:hostname] do |node|
      node.vm.box = server[:box]
      node.vm.hostname = server[:hostname]
      node.vm.network :private_network, ip: server[:ip]
      server[:synced_folders].each do |synced_folder|
        node.vm.synced_folder synced_folder[:host], synced_folder[:guest]
      end unless server[:synced_folders].nil?
    end
  end
end
