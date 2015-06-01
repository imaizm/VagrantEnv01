#
# Cookbook Name:: node.js
# Recipe:: express
#
bash "express" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm use v#{node.version}
		npm install -g express
	EOH
	action :nothing
	subscribes :run, "bash[nvm.sh]", :delayed
end
