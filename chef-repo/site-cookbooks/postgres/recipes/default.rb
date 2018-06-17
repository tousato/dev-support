#
# Cookbook Name:: postgres
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user = node['hha-common']['user']
password = node['hha-common']['password']
initd_script = "postgresql"

bash "set_credential" do
  user "postgres"
  group "postgres"
  not_if "psql -c \"select * from pg_user where usename='#{user}'\" | grep #{user}", :user => 'postgres'

  code <<-EOH
    set -vx
    psql -c "CREATE USER #{user} SUPERUSER"
    psql -c "ALTER USER #{user} PASSWORD '#{password}'"
    psql -c "CREATE DATABASE #{user} OWNER #{user}"
  EOH
end

ruby_block "edit postgresql.conf" do
    not_if "grep \"listen_addresses='*'\" /etc/postgresql/9.4/main/postgresql.conf"
    block do
      f = Chef::Util::FileEdit.new("/etc/postgresql/9.4/main/postgresql.conf")
      f.insert_line_after_match(/^#listen_addresses = 'localhost'/, 'listen_addresses=\'*\'')
      f.write_file
    end
    notifies :restart, "service[#{initd_script}]"
end

ruby_block "edit pg_hba.conf" do
    not_if "grep \"host *all *all *192.168.20.0/24\" /etc/postgresql/9.4/main/pg_hba.conf"
    block do
      f = Chef::Util::FileEdit.new("/etc/postgresql/9.4/main/pg_hba.conf")
      f.insert_line_after_match(/^host .*all .*all.*::1\/128 .*md5/, 'host    all             all             192.168.20.0/24         md5')
      f.write_file
    end
    notifies :restart, "service[#{initd_script}]"
end

service "#{initd_script}" do
  supports status: true, restart: true, reload: false
  action :nothing
end
