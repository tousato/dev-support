#
# Cookbook Name:: nodejs
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
user = node['hha-common']['user']
password = node['hha-common']['password']
node_version = "8.11.3"

bash 'nvm install' do
  code <<-EOH
    apt-get update
    apt-get install build-essential libssl-dev
    wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
  EOH
  not_if "grep NVM_DIR /home/#{user}/.bashrc"
end

bash 'node.js install' do
  user user
  code <<-EOH
    #source /home/#{user}/.bashrc
    source /home/#{user}/.nvm/nvm.sh
    nvm --version
    nvm install #{node_version}
    echo "nvm use #{node_version}" >> /home/#{user}/.bashrc
  EOH
  #not_if "grep \"nvm use\" /home/#{user}/.bashrc"
end
