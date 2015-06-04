#
# Cookbook Name:: node.js
# Recipe:: gulp
#
bash "gulp" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm use v#{node.version}
		npm install -g gulp
	EOH
	action :nothing
	subscribes :run, "bash[nvm.sh]", :immediately
end
