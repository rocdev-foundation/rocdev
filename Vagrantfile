# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 4000, host: 4000, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "docker" do |d|
    d.pull_images "postgres:10"
  end
  config.vm.provision "shell", name: "install", inline: <<-SHELL
    apt-get update
    apt-get install -y \
      make build-essential zlib1g-dev libsqlite3-dev libncurses5-dev \
      libyaml-dev libxslt-dev libffi-dev wget curl llvm xz-utils tk-dev \
      automake autoconf libreadline-dev libncurses-dev libbz2-dev libssl-dev \
      libtool tmux unixodbc-dev unzip \
      git vim

    su ubuntu -c 'git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.0'
    su ubuntu -c 'echo -e "\n. \\$HOME/.asdf/asdf.sh" >> ~/.bashrc'
    su ubuntu -c 'echo -e "\n. \\$HOME/.asdf/completions/asdf.bash" >> ~/.bashrc'
  SHELL
  config.vm.provision "shell", name: "asdf", inline: <<-SHELL
    su ubuntu -c '~/.asdf/bin/asdf plugin-add erlang'
    su ubuntu -c '~/.asdf/bin/asdf plugin-add elixir'
    su ubuntu -c '~/.asdf/bin/asdf plugin-add nodejs'
    su ubuntu -c '~/.asdf/plugins/nodejs/bin/import-release-team-keyring'
    su ubuntu -c '~/.asdf/bin/asdf plugin-add python'
    su ubuntu -c 'cd /vagrant && ~/.asdf/bin/asdf install'
    su ubuntu -c 'cd /vagrant && ~/.asdf/shims/pip install tmuxp'
    su ubuntu -c 'cd /vagrant && ~/.asdf/bin/asdf reshim python'
  SHELL
end
