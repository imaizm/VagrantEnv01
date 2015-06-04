#
# Cookbook Name:: node.js
# Recipe:: grant
#
bash "grunt" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm use v#{node.version}
		npm install -g grunt-cli
	EOH
	action :nothing
	subscribes :run, "bash[nvm.sh]", :immediately
end
