#
# Cookbook Name:: subversion-sample
# Recipe:: default
#
directory "/var/svn/repos/Sample" do
	action :create
end

execute "svnadmin create" do
	command <<-EOS
		svnadmin create /var/svn/repos/Sample
		svn mkdir file://localhost/var/svn/repos/Sample/trunk -m "create"
		svn mkdir file://localhost/var/svn/repos/Sample/branches -m "create"
		svn mkdir file://localhost/var/svn/repos/Sample/tags -m "create"
	EOS
	action :run
	not_if { ::File.exists?("/var/svn/repos/Sample/conf") }
end
