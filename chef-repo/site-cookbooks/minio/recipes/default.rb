#
# Cookbook Name:: minio
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "common"

directory '/opt/minio/bin' do
  owner 'm-sato'
  group 'm-sato'
  mode '0744'
  action :create
end

bash 'minio install' do
  code <<-EOH
    {
      wget -P /opt/minio/bin https://dl.minio.io/server/minio/release/linux-amd64/minio
      chmod +x /opt/minio/bin/minio
      /opt/minio/minio server 
    } > /tmp/chef_minio.log
  EOH
  not_if { File.exists?("/opt/minio/bin/minio") }
end

directory '/opt/minio/data' do
  owner 'm-sato'
  group 'm-sato'
  mode '0744'
  action :create
end

bash 'mc install' do
  code <<-EOH
    {
      wget -P /opt/minio/bin https://dl.minio.io/client/mc/release/linux-amd64/mc
      chmod +x /opt/minio/bin/mc
    } > /tmp/chef_minio-mc.log
  EOH
  not_if { File.exists?("/opt/minio/bin/mc") }
end

