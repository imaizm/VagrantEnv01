
template "sudoers_for_path" do
	path "/etc/sudoers.d/sudoers_for_path"
	owner "root"
	group "root"
	mode "0440"
	source "sudoers_for_path.erb"
end
