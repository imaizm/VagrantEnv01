template "google-chrome.repo" do
	path "/etc/yum.repos.d/google-chrome.repo"
	owner "root"
	group "root"
	mode "0644"
	source "google-chrome.repo.erb"
end
