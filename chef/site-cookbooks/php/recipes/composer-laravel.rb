#
# Cookbook Name:: php
# Recipe:: laravel
#

laravel_install_path = node["laravel"]["install_path"]

bash "Install laravel" do
	code  <<-EOS
		composer create-project laravel-ja/laravel #{laravel_install_path} dev-master --prefer-dist
	EOS
	action :run
	not_if { File.exists?("#{laravel_install_path}") }
end

template "httpd_laravel.conf" do
	path "/etc/httpd/conf.d/httpd_laravel.conf"
	owner "root"
	group "root"
	mode "0644"
	source "httpd_laravel.conf.erb"
	variables({
		:laravel_install_path => laravel_install_path
	})
	notifies :restart, "service[httpd]", :immediately
end

service 'httpd' do
	action :nothing
end
