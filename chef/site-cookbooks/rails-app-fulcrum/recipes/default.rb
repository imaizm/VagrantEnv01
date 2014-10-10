#
# Cookbook Name:: rails-app-fulcrum
# Recipe:: default
#
%w[
	mysql-devel
	postgresql-devel
	sqlite-devel
	nodejs
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end

git "/home/vagrant/fulcrum" do
	repository "git://github.com/fulcrum-agile/fulcrum.git"
	reference "master"
	action :sync
end

execute "install X Windows" do
	user "root"
	command 'yum -y groupinstall "X Window System" "Desktop" "General Purpose Desktop"'
	action :run
end

%w[
	firefox
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end

bash "bundle install" do
	cwd "/home/vagrant/fulcrum"
	code "bundle install"
	action :run
end

bash "bundle exec rake fulcrum:setup db:setup" do
	cwd "/home/vagrant/fulcrum"
	code "bundle exec rake fulcrum:setup db:setup"
	action :run
end
