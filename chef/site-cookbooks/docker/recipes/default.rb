#
# Cookbook Name:: docker
# Recipe:: default
#
package "docker-io" do
	action :install
end

service "docker" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

execute "docker pull" do
	command "docker pull #{node.image}"
	action :run
end

template "Dockerfile" do
	path "/tmp/Dockerfile"
	owner "root"
	group "root"
	mode "0644"
	source "Dockerfile.erb"
	variables(
		:image=>node['image']
	)
end