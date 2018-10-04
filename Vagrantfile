# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder ".", "/vagrant",
                          owner: 'ubuntu',
                          group: 'ubuntu'

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 4000, host: 4000, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8000, host: 8000, host_ip: "127.0.0.1"

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
    echo -e '\nexport ROCDEV_APP_HOST=$(route | awk "/default/ { print \\$2 }")' >> /home/ubuntu/.bashrc
    echo -e '\nexport MEETUP_API_BASE="" >> /home/ubuntu/.bashrc
    echo -e '\nexport SLACK_INVITE_API_BASE="" >> /home/ubuntu/.bashrc
    echo -e '\nexport SLACK_API_BASE="" >> /home/ubuntu/.bashrc
    echo -e '\nexport SLACK_API_TOKEN="" >> /home/ubuntu/.bashrc
    echo -e '\nexport ROCDEV_APP_HOST=$(route | awk "/default/ { print \\$2 }")' >> /home/ubuntu/.bashrc
    sudo gpasswd -a ubuntu docker
    apt-get update
    apt-get install -y \
      make build-essential zlib1g-dev libsqlite3-dev libncurses5-dev \
      libyaml-dev libxslt-dev libffi-dev wget curl llvm xz-utils tk-dev \
      automake autoconf libreadline-dev libncurses-dev libbz2-dev libssl-dev \
      libtool tmux unixodbc-dev unzip \
      git vim
    sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    su ubuntu -c 'git clone https://github.com/asdf-vm/asdf.git /home/ubuntu/.asdf --branch v0.4.1'
    echo -e "\n. /home/ubuntu/.asdf/asdf.sh" >> /home/ubuntu/.bashrc
    echo -e "\n. /home/ubuntu/.asdf/completions/asdf.bash" >> /home/ubuntu/.bashrc
  SHELL
  config.vm.provision "shell", name: "asdf", inline: <<-SHELL
    su ubuntu -c '~/.asdf/bin/asdf plugin-add erlang'
    su ubuntu -c '~/.asdf/bin/asdf plugin-add elixir'
    su ubuntu -c '~/.asdf/bin/asdf plugin-add python'
    su ubuntu -c '~/.asdf/bin/asdf plugin-add terraform'
    su ubuntu -c '~/.asdf/bin/asdf plugin-add nodejs'
    su ubuntu -c '~/.asdf/plugins/nodejs/bin/import-release-team-keyring'
    su ubuntu -c 'cd /vagrant && ~/.asdf/bin/asdf install'
    su ubuntu -c 'cd /vagrant && ~/.asdf/bin/asdf install'
    su ubuntu -c 'cd /vagrant && ~/.asdf/shims/pip install tmuxp'
    su ubuntu -c 'cd /vagrant && ~/.asdf/bin/asdf reshim python'
  SHELL
end
