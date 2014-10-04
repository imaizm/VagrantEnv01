%w[
	mysql-server
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end

service "mysqld" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

