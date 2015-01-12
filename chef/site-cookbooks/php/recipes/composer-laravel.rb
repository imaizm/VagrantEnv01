#
# Cookbook Name:: php
# Recipe:: laravel
#
bash "Install laravel" do
	code  <<-EOS
		composer create-project laravel-ja/laravel /var/www/laravel dev-master --prefer-dist
	EOS
	action :run
	not_if { File.exists?("/var/www/laravel") }
end
