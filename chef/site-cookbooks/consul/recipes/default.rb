package "unzip" do
	action :install
end

bash 'install consul' do
	cwd "/usr/local/bin"
	code <<-EOS
		cd /usr/local/bin
		curl -sSL https://releases.hashicorp.com/consul/0.5.2/consul_0.5.2_linux_amd64.zip -o consul.zip
		unzip consul.zip > /dev/null 2>&1
		rm consul.zip
		chmod +x consul

		mkdir /tmp/consul
		chmod 777 /tmp/consul
	EOS
	action :run
	not_if { ::File.exists?("/usr/local/bin/consul") }
end

template "consul.ini" do
	path "/etc/supervisord.d/consul.ini"
	owner "root"
	group "root"
	mode "0444"
	source "supervisor_consul.ini.erb"
end

service "supervisord" do
	action :reload
end
