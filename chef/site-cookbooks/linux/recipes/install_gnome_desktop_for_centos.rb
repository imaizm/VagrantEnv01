#
# Cookbook Name:: linux
# Recipe:: install_gnome_desktop
#

bash 'yum groupinstall Desktop' do
	code <<-EOS
		yum install -y epel-release
		yum --enablerepo=epel groupinstall -y "Xfce"
	EOS
end

directory "/home/vagrant/.vnc/" do
	owner "vagrant"
	group "vagrant"
	mode "0755"
	action :create
end

template "xstartup" do
	path "/home/vagrant/.vnc/xstartup"
	owner "vagrant"
	group "vagrant"
	mode "0755"
	source "xstartup_xfce4.erb"
end

# yum install -y epel-release
# yum --enablerepo=epel groupinstall -y "MATE Desktop"
# yum --enablerepo=epel groupinstall -y "Xfce"

# .Xclients
# echo "startxfce4" > ~/.Xclients
# echo "mate-session" > ~/.Xclients

%w[
	pixman
	pixman-devel
	libXfont
	vlgothic-fonts
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
	code <<-EOS
		echo "vagrant" > /tmp/vncpasswd-file
		echo "vagrant" >> /tmp/vncpasswd-file
		su -l -c "vncpasswd < /tmp/vncpasswd-file > /dev/null 2> /dev/null" vagrant
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
