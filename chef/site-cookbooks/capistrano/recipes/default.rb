
execute "rbenv exec gem install capistrano" do
	command "source /etc/profile.d/rbenv.sh; rbenv exec gem install --no-ri --no-rdoc capistrano"
	action :run
	not_if { ::File.exists?("/usr/local/rbenv/versions/#{node.build}/bin/cap") }
end

execute "rbenv rehash" do
	command "source /etc/profile.d/rbenv.sh; rbenv rehash"
	action :run
end
