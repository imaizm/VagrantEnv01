
remote_file "#{Chef::Config[:file_cache_path]}/#{node['maven']['download']['file']}" do
	source node["maven"]["download"]["url"]
	action :create
	not_if { File.exists?("/usr/local/#{node['maven']['download']['basename']}") }
end

bash "unarchive downloaded file" do
	cwd "/usr/local"
	code "tar xf #{Chef::Config[:file_cache_path]}/#{node['maven']['download']['file']}"
	action :run
	not_if { File.exists?("/usr/local/#{node['maven']['download']['basename']}") }
end

bash "Create /etc/profile.d/add_MAVEN_BIN_to_PATH.sh" do
	code  <<-EOS
		echo "export PATH=\\$PATH:/usr/local/#{node['maven']['download']['basename']}/bin" > /etc/profile.d/add_MAVEN_BIN_to_PATH.sh
		source /etc/profile
	EOS
	action :run
	not_if { File.exists?("/etc/profile.d/add_MAVEN_BIN_to_PATH.sh") }
end
