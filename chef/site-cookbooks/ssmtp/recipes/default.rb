
package "ssmtp" do
	action :install
	notifies :run, "bash[set mta ssmtp]", :immediately
end

bash "set mta ssmtp" do
	cwd "/usr/sbin/"
	code "alternatives --set mta /usr/sbin/sendmail.ssmtp"
	action :nothing
end

template "ssmtp.conf" do
	path "/etc/ssmtp/ssmtp.conf"
	owner "root"
	group "root"
	mode "0644"
	source "ssmtp.conf_2.61-21.el6_gmail.erb"
	variables({
		:gmail_account => node['gmail_account'],
		:gmail_account_password => node['gmail_account_password']
	})
end
