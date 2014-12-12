#
# Cookbook Name:: docker
# Recipe:: chef-container
#
ruby_version = `source /etc/profile.d/rbenv.sh; rbenv global`.chop

execute "rbenv exec gem install knife-solo" do
	command "source /etc/profile.d/rbenv.sh; rbenv exec gem install --no-ri --no-rdoc knife-solo"
	action :run
	not_if { ::File.exists?("/usr/local/rbenv/versions/#{ruby_version}/bin/knife") }
end

execute "rbenv exec gem install berkshelf" do
	command "source /etc/profile.d/rbenv.sh; rbenv exec gem install --no-ri --no-rdoc berkshelf"
	action :run
	not_if { ::File.exists?("/usr/local/rbenv/versions/#{ruby_version}/bin/berks") }
end

execute "rbenv exec gem install knife-container" do
	command "source /etc/profile.d/rbenv.sh; rbenv exec gem install --no-ri --no-rdoc knife-container"
	action :run
	only_if { ::Dir.glob("/usr/local/rbenv/versions/#{ruby_version}/lib/ruby/gems/*/gems/knife-container-*").empty? }
end

execute "rbenv rehash" do
	command "source /etc/profile.d/rbenv.sh; rbenv rehash"
	action :run
end
