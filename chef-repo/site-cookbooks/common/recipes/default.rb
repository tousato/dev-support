#
# Cookbook Name:: common
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
directory '/opt/' do
  owner 'm-sato'
  group 'm-sato'
  mode '0744'
  action :create
end
