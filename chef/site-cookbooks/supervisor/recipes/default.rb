
package "supervisor" do
	action :install
end

template "supervisord.conf" do
	path "/etc/supervisord.conf"
	owner "root"
	group "root"
	mode "0440"
	source "supervisord.conf_default.erb"
end

#service "supervisord" do
#	supports :status => true, :restart => true, :reload => true
#	action [ :enable, :start ]
#end
