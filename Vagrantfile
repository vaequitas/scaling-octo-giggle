# -*- mode: ruby -*-
# vi: set ft=ruby :

servers = [
  {
    :hostname => 'vag-app-01',
    :ip => '192.168.33.21',
    :box => 'geerlingguy/centos7',
    :synced_folders => [
      {
        :host => '../app',
        :guest => '/var/sites/app',
      },
    ],
    :provisioners => {
      :puppet => {
        :manifest_file => 'app.pp',
        :facter        => {
          'server_role' => 'app',
        },
      },
    },
  },
  {
    :hostname => 'vag-app-02',
    :ip => '192.168.33.22',
    :box => 'geerlingguy/centos7',
    :synced_folders => [
      {
        :host => '../app',
        :guest => '/var/sites/app',
      },
    ],
    :provisioners => {
      :puppet => {
        :manifest_file => 'app.pp',
        :facter        => {
          'server_role' => 'app',
        },
      },
    },
  },
  {
    :hostname => 'vag-web-01',
    :ip => '192.168.33.11',
    :box => 'geerlingguy/centos7',
    :provisioners => {
      :puppet => {
        :manifest_file => 'web.pp',
        :facter        => {
          'server_role' => 'web',
        },
      },
    },
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

      node.vm.provision :puppet do |puppet|
        puppet.manifests_path    = "../puppet/manifests"
        puppet.module_path       = ["../puppet/modules/custom", "../puppet/modules/forge"]
        puppet.manifest_file     = server[:provisioners][:puppet][:manifest_file]
        puppet.facter            = server[:provisioners][:puppet][:facter]
        puppet.hiera_config_path = "hiera/hiera.yaml"
        puppet.working_directory = "/tmp/vagrant-puppet"
      end

    end
  end
end
