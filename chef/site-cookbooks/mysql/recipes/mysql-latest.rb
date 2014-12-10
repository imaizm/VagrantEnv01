remote_file "#{Chef::Config[:file_cache_path]}/mysql-community-release-el6-5.noarch.rpm" do
	source 'http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm'
	action :create
end

rpm_package "mysql-community-release" do
	source "#{Chef::Config[:file_cache_path]}/mysql-community-release-el6-5.noarch.rpm"
	action :install
end

# install mysql community server
yum_package "mysql-community-server" do
  action :install
  flush_cache [:before]
end

=begin
%w[
	mysql-devel
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end
=end

service "mysqld" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

template "my.cnf" do
	path "/etc/my.cnf"
	owner "root"
	group "root"
	mode "0644"
	source "my.cnf_5.6_default.erb"
	variables(
		:innodb_buffer_pool_size => node['innodb_buffer_pool_size']
	)
	notifies :restart, "service[mysqld]", :immediately
end
