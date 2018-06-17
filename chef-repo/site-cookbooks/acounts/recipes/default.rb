#
# Cookbook Name:: acounts
# Recipe:: default
#
# Copyright 2018, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
users = data_bag('users')
users.each do |user|
  u = data_bag_item('users', user)
  user u['id'] do
    home u['home']
    group u['group']
    shell u['shell']
    manage_home true
    action :create
  end

  user = u['id']
  group = u['group']
  private_key = u['private']
  public_key = u['public'] 

  # ssh keyファイル設定
  directory "/home/#{user}/.ssh" do
    owner user
    group group
    mode 0700
    action :create
  end

  files = [["/home/#{user}/.ssh/id_rsa","#{private_key}"], ["/home/#{user}/.ssh/id_rsa.pub","#{public_key}"] ]
  files.each do |file|
    file file[0] do
      content file[1]
      mode  0600
      owner user
      group group
      action :create_if_missing
    end
  end
end
