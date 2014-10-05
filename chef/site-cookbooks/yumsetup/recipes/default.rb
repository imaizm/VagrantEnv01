#
# Cookbook Name:: yumsetup
# Recipe:: default
#
yum_package "yum-fastestmirror" do
	action :install
end

execute "yum-update" do
	user "root"
	command "yum -y update"
	action :run
end
