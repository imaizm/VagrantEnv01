#
# Cookbook Name:: node.js
# Recipe:: bower
#
bash "express" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm use v#{node.version}
		npm install -g bower
	EOH
	action :nothing
	subscribes :run, "bash[nvm.sh]", :immediately
end
