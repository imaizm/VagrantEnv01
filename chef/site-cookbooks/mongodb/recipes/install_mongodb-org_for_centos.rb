template "mongodb.repo" do
	path "/etc/yum.repos.d/mongodb.repo"
	owner "root"
	group "root"
	mode "0644"
	source "mongodb.repo.erb"
end

package "mongodb-org" do
	action :install
end

service "mongod" do
	action [:enable, :start]
end
