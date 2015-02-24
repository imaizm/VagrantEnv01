user node['git']['install_user_name'] do
	password node['git']['install_user_password']
	home node['git']['install_user_home']
	action :create
end

directory node['git']['install_user_home'] do
	owner node['git']['install_user_name']
	group node['git']['install_user_name']
	mode "0750"
	action :create
end

directory "#{node['git']['install_user_home']}/.ssh/" do
	owner node['git']['install_user_name']
	group node['git']['install_user_name']
	mode "0700"
	action :create
end

file "#{node['git']['install_user_home']}/.ssh/authorized_keys" do
	owner node['git']['install_user_name']
	group node['git']['install_user_name']
	mode "0600"
	action :create
end

node['git']['repositories'].each do |repository|
	directory "#{node['git']['install_user_home']}/#{repository}" do
		owner node['git']['install_user_name']
		group node['git']['install_user_name']
		mode "0750"
		action :create
	end
	bash "init git repository" do
		cwd node['git']['install_user_home']
		user node['git']['install_user_name']
		group node['git']['install_user_name']
		code "git init --bare --shared=0640 #{repository}"
		action :run
		not_if { File.exists?("#{node['git']['install_user_home']}/#{repository}/config") }
	end
end

node['git']['remote_users_with_local_account'].each do |target_user|
	bash "add authorized key from target_user home" do
		cwd node['git']['install_user_home']
		code "cat /home/#{target_user}/.ssh/authorized_keys >> .ssh/authorized_keys"
		action :run
		only_if {
			File.exists?("/home/#{target_user}/.ssh/authorized_keys") &&
			`grep -f /home/#{target_user}/.ssh/authorized_keys #{node['git']['install_user_home']}/.ssh/authorized_keys`.chop == ""
		}
	end
end
