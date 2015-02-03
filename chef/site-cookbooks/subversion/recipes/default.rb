#
# Cookbook Name:: subversion
# Recipe:: default
#
package "subversion" do
	action :remove
end

package "subversion" do
	action :install
	options '--enablerepo=wandisco-svn --disablerepo=base,updates,epel'
end

template "svnserve" do
	path "/etc/init.d/svnserve"
	owner "root"
	group "root"
	mode "0755"
	source "init.d_svnserve_1.6.11.el6_5_original.erb"
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
