execute "rpm import jenkins-ci.org.key" do
	command "rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
	action :run
	not_if { ::File.exists?("/etc/yum.repos.d/jenkins.repo") }
end

remote_file "/etc/yum.repos.d/jenkins.repo" do
	source "http://pkg.jenkins-ci.org/redhat/jenkins.repo"
	action :create
end
