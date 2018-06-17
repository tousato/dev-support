#
# Cookbook Name:: nodejs
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash 'node js install' do
  code <<-EOH
    apt-get update
    apt-get install build-essential libssl-dev
    wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
    source ~/.bashrc
    chown -R m-sato:m-sato .nvm
    nvm install 6.10.3      
    nvm use 6.10.3
  EOH
end
