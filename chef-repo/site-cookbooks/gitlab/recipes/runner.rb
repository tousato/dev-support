#
# Cookbook Name:: gitlab
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash 'gitlabci-runner install' do
  code <<-EOH
    {
      curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash

    } > /tmp/chef_gitlabci-runner.log
  EOH
end




