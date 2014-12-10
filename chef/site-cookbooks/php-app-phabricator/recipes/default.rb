#
# Cookbook Name:: php-app-phabricator
# Recipe:: default
#
directory "/var/www/html/phabricator" do
	action :create
end

git "/var/www/html/phabricator/libphutil" do
	repository "git://github.com/phacility/libphutil.git"
	reference "master"
	action :sync
end

git "/var/www/html/phabricator/arcanist" do
	repository "git://github.com/phacility/arcanist.git"
	reference "master"
	action :sync
end

git "/var/www/html/phabricator/phabricator" do
	repository "git://github.com/phacility/phabricator.git"
	reference "master"
	action :sync
	timeout 1200
end

directory "/var/www/html/phabricator/phabricator/conf/custom" do
	action :create
end

# PHP Settings
%w[
	php-pear
	php-pecl-apc
	php-gd
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end

# MySQL Settings

mysql_user          = node['mysql_user']
mysql_user_password = node['mysql_user_password']
repository_path     = node['repository_path']

template "#{Chef::Config[:file_cache_path]}/mysql_create_user.sql" do
	owner 'root'
	group 'root'
	mode 644
	source 'mysql_create_user.sql.erb'
	variables({
		:mysql_user          => mysql_user,
		:mysql_user_password => mysql_user_password
	})
end

execute 'create_user' do
  command "/usr/bin/mysql -u root < #{Chef::Config[:file_cache_path]}/mysql_create_user.sql"
  action :run
  not_if "/usr/bin/mysql -u #{mysql_user} -p#{mysql_user_password}"
end

# Phabricator Settings

template "myconfig.conf.php" do
	path "/var/www/html/phabricator/phabricator/conf/custom/myconfig.conf.php"
	owner "root"
	group "root"
	mode "0644"
	source "myconfig.conf.php.erb"
	variables({
		:mysql_user          => mysql_user,
		:mysql_user_password => mysql_user_password,
		:repository_path     => repository_path
	})
#	notifies :run, "bash[Upgrade Phabricator storage]", :immediately
	notifies :restart, "service[httpd]", :immediately
end

bash "Upgrade Phabricator storage" do
	cwd "/var/www/html/phabricator/phabricator/"
	code "./bin/storage upgrade --force"
#	action :run
	action :nothing
end

# apache Settings

template "httpd_phabricator.conf" do
	path "/etc/httpd/conf.d/httpd_phabricator.conf"
	owner "root"
	group "root"
	mode "0644"
	source "httpd_phabricator.conf.erb"
	notifies :restart, "service[httpd]", :immediately
end

service 'httpd' do
	action :nothing
end


# MEMO ########################################################################
=begin
+--------------------------+
| Database                 |
+--------------------------+
| information_schema       |
| mysql                    |
| phabricator_almanac      |
| phabricator_audit        |
| phabricator_auth         |
| phabricator_cache        |
| phabricator_calendar     |
| phabricator_chatlog      |
| phabricator_conduit      |
| phabricator_config       |
| phabricator_conpherence  |
| phabricator_countdown    |
| phabricator_daemon       |
| phabricator_dashboard    |
| phabricator_differential |
| phabricator_diviner      |
| phabricator_doorkeeper   |
| phabricator_draft        |
| phabricator_drydock      |
| phabricator_fact         |
| phabricator_feed         |
| phabricator_file         |
| phabricator_flag         |
| phabricator_fund         |
| phabricator_harbormaster |
| phabricator_herald       |
| phabricator_legalpad     |
| phabricator_maniphest    |
| phabricator_meta_data    |
| phabricator_metamta      |
| phabricator_nuance       |
| phabricator_oauth_server |
| phabricator_owners       |
| phabricator_passphrase   |
| phabricator_pastebin     |
| phabricator_phame        |
| phabricator_phlux        |
| phabricator_pholio       |
| phabricator_phortune     |
| phabricator_phragment    |
| phabricator_phrequent    |
| phabricator_phriction    |
| phabricator_policy       |
| phabricator_ponder       |
| phabricator_project      |
| phabricator_releeph      |
| phabricator_repository   |
| phabricator_search       |
| phabricator_slowvote     |
| phabricator_system       |
| phabricator_token        |
| phabricator_user         |
| phabricator_worker       |
| phabricator_xhpastview   |
| phabricator_xhprof       |
| test                     |
+--------------------------+
=end
