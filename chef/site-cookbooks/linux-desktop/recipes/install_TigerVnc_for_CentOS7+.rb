#
# Cookbook Name:: linux-desktop
# Recipe:: install_TigerVnc_for_CentOS7+
#
directory "/home/#{node['vnc']['user']}/.vnc/" do
	owner node['vnc']['user']
	group node['vnc']['user']
	mode "0755"
	action :create
end

template "xstartup" do
	path "/home/#{node['vnc']['user']}/.vnc/xstartup"
	owner node['vnc']['user']
	group node['vnc']['user']
	mode "0755"
	source "xstartup_xfce4.erb"
end

package "tigervnc-server" do
	action :install
	notifies :run, "bash[add vnc-server to firewalld]", :immediately
end

bash 'add vnc-server to firewalld' do
	code <<-EOS
		firewall-cmd --permanent --add-service vnc-server
		systemctl restart firewalld.service
	EOS
	action :nothing
end

template "vncserver@:1.service" do
	path "/etc/systemd/system/vncserver@:1.service"
	owner "root"
	group "root"
	mode "0644"
	source "vncserver@.service_default.erb"
	variables(
		:user => node['vnc']['user']
	)
	notifies :run, "bash[reload tigervnc-server]", :immediately
end

bash 'reload tigervnc-server' do
	code <<-EOS
		systemctl daemon-reload
		systemctl enable vncserver@:1.service
	EOS
	action :nothing
	notifies :run, "bash[set vncpasswd]", :immediately
end

bash "set vncpasswd" do
	code <<-EOS
		echo #{node['vnc']['password']} > /tmp/vncpasswd-file
		echo #{node['vnc']['password']} >> /tmp/vncpasswd-file
		su -l -c "vncpasswd < /tmp/vncpasswd-file > /dev/null 2> /dev/null" #{node['vnc']['user']}
		rm /tmp/vncpasswd-file
	EOS
	action :nothing
	notifies :run, "bash[start tigervnc-server]", :immediately
end

bash 'start tigervnc-server' do
	code <<-EOS
		systemctl start vncserver@:1.service
	EOS
	action :nothing
end
