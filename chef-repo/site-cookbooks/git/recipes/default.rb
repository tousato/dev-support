#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash 'git install' do
  code <<-EOH
    {
      apt-get -y install git
    } > /tmp/chef_gradle.log
  EOH
end
