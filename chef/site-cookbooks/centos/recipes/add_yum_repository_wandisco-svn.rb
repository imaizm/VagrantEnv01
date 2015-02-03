template "wandisco-svn.repo" do
	path "/etc/yum.repos.d/wandisco-svn.repo"
	owner "root"
	group "root"
	mode "0644"
	source "wandisco-svn.repo.erb"
end
