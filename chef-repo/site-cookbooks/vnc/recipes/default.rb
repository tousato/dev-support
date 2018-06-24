#
# vnc
#
user = node['hha-common']['user']
vnc_no = "1"

apt_update 'all platforms' do
  frequency 86400
  action :periodic
end
packages.each do |package|
  apt_package "#{package}" do
    action :install
  end
end

directory "/home/#{user}/.vnc" do
  owner user
  group group
  action :create
  not_if "test -d /home/#{user}/.vnc"
end

cookbook_file "/home/#{user}/.vnc/passwd" do
  source "#{user}/passwd"
  owner user
  group group
  mode 0600
  action :create
  not_if "test -f /home/#{user}/.vnc/passwd"
end

bash 'vnc server' do
  user user
  group group
  code <<-EOH
    set -vx
    vncserver :#{vnc_no}
    vncserver -kill :#{vnc_no}
    echo "startxfce4 &" >> /home/#{user}/.vnc/xstartup
    vncserver :#{vnc_no}
  EOH
#    not_if "ps axu | grep vncserver"
end
