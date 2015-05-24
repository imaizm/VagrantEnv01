#
# Cookbook Name:: node.js
# Recipe:: sample_01
#
bash "npm install for sample_01" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm use v#{node.version}
		cd /var/www/src/node.js_sample_01
		npm install
	EOH
#	action :nothing
#	subscribes :run, "bash[nvm.sh]", :delayed
end
