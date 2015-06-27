#
# Cookbook Name:: node.js
# Recipe:: sample_01
#
bash "npm install for sample_04" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm use v#{node.version}
		cd /var/www/src
		npm install --no-bin-links
	EOH
#		pm2 startOrRestart ecosystem.json --watch
end
