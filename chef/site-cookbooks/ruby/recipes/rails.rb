#
# Cookbook Name:: ruby
# Recipe:: rails
#
execute "rbenv exec gem install rails" do
	command "source /etc/profile.d/rbenv.sh; rbenv exec gem install --no-ri --no-rdoc rails"
	action :run
	not_if { ::File.exists?("/usr/local/rbenv/versions/#{node.build}/bin/rails") }
end

execute "rbenv rehash" do
	command "source /etc/profile.d/rbenv.sh; rbenv rehash"
	action :run
end
