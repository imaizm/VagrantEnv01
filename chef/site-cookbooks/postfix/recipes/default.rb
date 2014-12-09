
package "postfix" do
	action :install
	notifies :run, "bash[set mta postfix]", :immediately
end

bash "set mta postfix" do
	cwd "/usr/sbin/"
	code "alternatives --set mta /usr/sbin/sendmail.postfix"
#	action :run
	action :nothing
end

service 'postfix' do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

=begin
template "main.cf" do
	path "/etc/postfix/main.cf"
	owner "root"
	group "root"
	mode "0644"
	source "main.cf_2.6.6_default.erb"
#	variables({
#		:mysql_username => user_name,
#		:mysql_password => user_password,
#	})
	notifies :restart, "service[postfix]", :immediately
end
=end
