execute "rpm import jenkins-ci.org.key" do
	command "rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm"
	action :run
#	not_if { ::File.exists?("/etc/yum.repos.d/epel.repo") }
end
