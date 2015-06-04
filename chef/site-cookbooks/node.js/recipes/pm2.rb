#
# Cookbook Name:: node.js
# Recipe:: pm2
#
bash "pm2" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm use v#{node.version}
		npm install -g pm2
	EOH
	action :nothing
	subscribes :run, "bash[nvm.sh]", :immediately
end
