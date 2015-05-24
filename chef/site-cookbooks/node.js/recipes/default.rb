#
# Cookbook Name:: nodejs
# Recipe:: default
#
git "/usr/local/nvm" do
	repository "git://github.com/creationix/nvm.git"
	reference "master"
	notifies :run, "bash[nvm.sh]", :immediately
end

bash "nvm.sh" do
	code <<-EOH
		. /usr/local/nvm/nvm.sh
		nvm install v#{node.version}
	EOH
	action :nothing
end

template "nvm.sh" do
	path "/etc/profile.d/nvm.sh"
	owner "root"
	group "root"
	mode "0644"
	source "nvm.sh.erb"
end

