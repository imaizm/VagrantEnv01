remote_file "#{Chef::Config[:file_cache_path]}/pgdg-centos94-9.4-1.noarch.rpm" do
	source 'http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm'
	action :create
end

rpm_package "pgdg-centos94" do
	source "#{Chef::Config[:file_cache_path]}/pgdg-centos94-9.4-1.noarch.rpm"
	action :install
end

%w[
	postgresql94
	postgresql94-devel
	postgresql94-libs
	postgresql94-server
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end

service "postgresql-9.4" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end
