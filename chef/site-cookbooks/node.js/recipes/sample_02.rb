#
# Cookbook Name:: node.js
# Recipe:: sample_01
#
bash "npm install for sample_02" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm use v#{node.version}
		cd /var/www/src/node.js_sample_02
		npm install --no-bin-links
		pm2 startOrRestart ecosystem.json --watch
	EOH
end
