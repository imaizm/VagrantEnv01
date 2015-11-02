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
end
