#
# Cookbook Name:: elixir
# Recipe:: default
#
package "ncurses-devel" do
	action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/otp_src_18.1.tar.gz" do
	source "http://www.erlang.org/download/otp_src_18.1.tar.gz"
	action :create
	notifies :run, 'bash[make and install erlang]', :immediately
end

bash 'make and install erlang' do
	action :nothing
	cwd "#{Chef::Config[:file_cache_path]}"
	code <<-EOH
tar xzf #{Chef::Config[:file_cache_path]}/otp_src_18.1.tar.gz
cd #{Chef::Config[:file_cache_path]}/otp_src_18.1
./configure
make
make install
EOH
end

git "/usr/local/elixir" do
	repository "https://github.com/elixir-lang/elixir.git"
	reference "master"
	action :sync
	notifies :run, 'bash[make elixir]', :immediately
end

bash 'make elixir' do
	action :nothing
	code <<-EOH
cd /usr/local/elixir
make clean test
EOH
end
