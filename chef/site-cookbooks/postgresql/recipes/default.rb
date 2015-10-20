%w[
	postgresql
	postgresql-devel
	postgresql-libs
	postgresql-server
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end

service "postgresql" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end
