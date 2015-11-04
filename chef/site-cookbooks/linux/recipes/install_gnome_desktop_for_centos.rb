#
# Cookbook Name:: linux
# Recipe:: install_gnome_desktop
#
bash 'yum update' do
	code <<-EOS
		yum update -y
	EOS
end

bash 'yum groupinstall Desktop' do
	code <<-EOS
		yum groupinstall -y "Desktop"
	EOS
end

%w[
	pixman
	pixman-devel
	libXfont
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
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
		:user => "vagrant"
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
	user "vagrant"
	group "vagrant"
	cwd "/home/vagrant"
	code <<-EOS
		mkdir /home/vagrant/.vnc
		echo vagrant | vncpasswd -f > /home/vagrant/.vnc/passwd
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
