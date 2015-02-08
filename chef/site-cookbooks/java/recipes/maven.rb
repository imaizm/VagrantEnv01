
download_file = node["maven"]["download"]["file"]

remote_file "#{Chef::Config[:file_cache_path]}/#{download_file}" do
	source node["maven"]["download"]["url"]
	action :create
end
