#
# Cookbook Name:: nodejs
# Recipe:: grant
#
bash "gulp" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm use v#{node.version}
		npm install -g gulp
	EOH
	action :nothing
	subscribes :run, "bash[nvm.sh]", :delayed
end
