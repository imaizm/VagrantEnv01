#
# Cookbook Name:: linux-desktop
# Recipe:: install_Xfce-Desktop_for_CentOS7+
#
bash 'yum groupinstall Desktop' do
	code <<-EOS
		yum install -y epel-release
		yum --enablerepo=epel groupinstall -y "Xfce"
	EOS
end

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

# ----- memo -----

# yum install -y epel-release
# yum --enablerepo=epel groupinstall -y "MATE Desktop"
# yum --enablerepo=epel groupinstall -y "Xfce"

# .Xclients
# echo "startxfce4" > ~/.Xclients
# echo "mate-session" > ~/.Xclients
