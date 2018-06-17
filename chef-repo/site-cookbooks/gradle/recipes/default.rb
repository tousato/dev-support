#
# Cookbook Name:: gradle
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash 'java install' do
  code <<-EOH
    {
      apt-get install software-properties-common python-software-properties
      add-apt-repository -y ppa:cwchien/gradle
      apt-get update
      apt-get -y install gradle
    } > /tmp/chef_gradle.log
  EOH
end
