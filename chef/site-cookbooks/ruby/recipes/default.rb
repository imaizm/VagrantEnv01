#
# Cookbook Name:: ruby
# Recipe:: default
#
git "/usr/local/rbenv" do
	repository "git://github.com/sstephenson/rbenv.git"
	reference "master"
	action :sync
end

%w[
	/usr/local/rbenv/shims
	/usr/local/rbenv/versions
].each do |dir|
	directory dir do
		action :create
	end
end

git "/usr/local/ruby-build" do
	repository "git://github.com/sstephenson/ruby-build.git"
	reference "master"
	action :sync
end

bash "install_ruby_build" do
	cwd "/usr/local/ruby-build"
	code "./install.sh"
	action :run
	not_if { ::File.exists?("/usr/local/share/ruby-build") }
end

template "rbenv.sh" do
	path "/etc/profile.d/rbenv.sh"
	owner "root"
	group "root"
	mode "0644"
	source "rbenv.sh.erb"
end

template "sudoers_for_ruby" do
	path "/etc/sudoers.d/sudoers_for_ruby"
	owner "root"
	group "root"
	mode "0440"
	source "sudoers_for_ruby.erb"
end

%w[
	make
	gcc
	zlib-devel
	openssl-devel
	readline-devel
	ncurses-devel
	gdbm-devel
	db4-devel
	libffi-devel
	tk-devel
	libyaml-devel
].each do |pkg|
	yum_package pkg do
		action :install
	end
end

execute "rbenv install" do
	command "source /etc/profile.d/rbenv.sh; rbenv install #{node.build}"
	action :run
	not_if { ::File.exists?("/usr/local/rbenv/versions/#{node.build}") }
end

execute "rbenv global" do
	command "source /etc/profile.d/rbenv.sh; rbenv global #{node.build}"
	action :run
end

execute "rbenv rehash" do
	command "source /etc/profile.d/rbenv.sh; rbenv rehash"
	action :run
end

execute "rbenv exec gem install rubygems-update" do
	command "source /etc/profile.d/rbenv.sh; rbenv exec gem install --no-ri --no-rdoc rubygems-update"
	action :run
	not_if { ::File.exists?("/usr/local/rbenv/versions/#{node.build}/bin/update_rubygems") }
end

execute "rbenv exec gem install bundler" do
	command "source /etc/profile.d/rbenv.sh; rbenv exec gem install --no-ri --no-rdoc bundler"
	action :run
	not_if { ::File.exists?("/usr/local/rbenv/versions/#{node.build}/bin/bundler") }
end

execute "rbenv rehash" do
	command "source /etc/profile.d/rbenv.sh; rbenv rehash"
	action :run
end

=begin
# gem_package version
gem_package "bundler" do
	options "--no-ri --no-rdoc"
end
=end
