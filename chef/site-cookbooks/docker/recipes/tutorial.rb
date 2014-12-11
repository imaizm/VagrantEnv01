#
# Cookbook Name:: docker
# Recipe:: tutorial
#
execute "knife container docker init" do
	user "vagrant"
	group "vagrant"
	cwd "/home/vagrant"
	command "source /etc/profile.d/rbenv.sh; knife container docker init centos:centos6 -r 'recipe[apache2]' -z -b"
	action :run
	not_if { ::File.exists?("/home/vagrant/dockerfiles") }
end

template "first-boot.json" do
	path "/home/vagrant/first-boot.json"
	owner "vagrant"
	group "vagrant"
	mode "0644"
	source "tutorial_first-boot.json.erb"
end

# sudo knife container docker build centos:centos6 -z
# sudo docker images
# sudo docker run chef/ubuntu-12.04
# sudo docker ps
