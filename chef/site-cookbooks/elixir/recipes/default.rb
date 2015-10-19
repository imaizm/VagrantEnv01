#
# Cookbook Name:: elixir
# Recipe:: default
#
%w[
	gcc
	glibc-devel
	make
	ncurses-devel
	openssl-devel
	autoconf
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end


remote_file "#{Chef::Config[:file_cache_path]}/otp_src_18.1.tar.gz" do
	source "http://www.erlang.org/download/otp_src_18.1.tar.gz"
	action :create
	notifies :run, 'bash[make and install erlang]', :immediately
end

bash 'make and install erlang' do
	action :nothing
	cwd "#{Chef::Config[:file_cache_path]}"
	code <<-EOS
		tar xzf #{Chef::Config[:file_cache_path]}/otp_src_18.1.tar.gz
		cd #{Chef::Config[:file_cache_path]}/otp_src_18.1
		./configure
		make
		make install
	EOS
end

git "/usr/local/elixir" do
	repository "https://github.com/elixir-lang/elixir.git"
	reference "master"
	action :sync
	notifies :run, 'bash[make elixir]', :immediately
end

bash 'make elixir' do
	action :nothing
	code <<-EOS
		cd /usr/local/elixir
		make clean test
	EOS
end

template "setPATH_for_elixir.sh" do
	path "/etc/profile.d/setPATH_for_exlixir.sh"
	owner "root"
	group "root"
	mode "0644"
	source "setPATH_for_elixir.sh.erb"
end

bash 'install Hex by mix' do
	action :run
	code <<-EOS
		mix local.hex
	EOS
end
