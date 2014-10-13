#
# Cookbook Name:: subversion
# Recipe:: default
#
package "subversion" do
	action :install
end

service "svnserve" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

%w[
	/var/svn
	/var/svn/repos
].each do |dir|
	directory dir do
		action :create
	end
end
