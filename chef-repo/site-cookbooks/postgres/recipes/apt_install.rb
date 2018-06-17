#
# Cookbook Name:: postgres
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

postgres = node['postgresql']
p postgres
user = node['postgresql']['user']
password = node['postgresql']['password']

packages = []
packages += %w[postgresql-9.4]

apt_package packages do
  action :nothing
end

bash "inport_key_update" do
  code <<-EOH
  {
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
      sudo apt-key add -
    sudo apt-get update
  } >> /tmp/chef_postgres.log
  EOH
  action :nothing
  notifies :run, resources( :apt_package => "#{packages}" )  
end

cookbook_file "/etc/apt/sources.list.d/pgdg.list" do
  not_if "test -f /etc/apt/sources.list.d/pgdg.list"
  source "pgdg.list"
  notifies :run, resources( :bash => "inport_key_update" )
end

apt_package packages do
end

bash "set_credential" do
  user "postgres"
  group "postgres"
  not_if "psql -c \"select * from pg_user where usename='#{user}'\" | grep #{user}", :user => 'postgres'

  code <<-EOH
    psql -c "CREATE USER #{user} SUPERUSER"
    psql -c "ALTER USER #{user} PASSWORD '#{password}'"
    psql -c "CREATE DATABASE #{user} OWNER #{user}"
  EOH
end
