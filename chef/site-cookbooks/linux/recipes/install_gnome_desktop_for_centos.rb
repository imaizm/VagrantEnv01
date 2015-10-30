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
