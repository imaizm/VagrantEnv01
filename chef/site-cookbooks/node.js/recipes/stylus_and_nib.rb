#
# Cookbook Name:: node.js
# Recipe:: stylus and nib
#
bash "stylus and nib" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm use v#{node.version}
		npm install -g stylus nib
	EOH
	action :nothing
	subscribes :run, "bash[nvm.sh]", :immediately
end
