#
# Cookbook Name:: subversion-Submin
# Recipe:: default
#
%w[
	httpd
	python
	mod_wsgi
	mod_dav_svn
	apr-util-sqlite
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end

execute "check" do
	not_if { File.exists?("/usr/local/bin/submin-admin") }
	command "echo 'not installed'"
	action :run
	notifies :create, "remote_file[/tmp/submin-#{node.build}.tar.gz]", :immediately
	notifies :run, "execute[tar xf]", :immediately
	notifies :run, "execute[install]", :immediately
	notifies :run, "execute[init]", :immediately
end


remote_file "/tmp/submin-#{node.build}.tar.gz" do
	source "http://supermind.nl/submin/current/submin-#{node.build}.tar.gz"
	action :nothing
end

execute "tar xf" do
	cwd "/tmp"
	command "tar xf submin-#{node.build}.tar.gz"
	action :nothing
end

execute "install" do
	cwd "/tmp/submin-#{node.build}/bin"
	command "python install.py /usr/local"
	action :nothing
end

execute "init" do
	command <<-EOS
		/usr/local/bin/submin-admin create default
		ln -s /etc/submin/default-apache-wsgi.conf /etc/httpd/conf.d/submin01_default-apache-wsgi.conf
		ln -s /etc/submin/default-apache-cgi.conf /etc/httpd/conf.d/submin02_default-apache-cgi.conf
	EOS
	action :nothing
end

template "submin00_LoadModules.conf" do
	path "/etc/httpd/conf.d/submin00_LoadModules.conf"
	owner "root"
	group "root"
	mode "0644"
	source "submin00_LoadModules.conf.erb"
end

service 'httpd' do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

=begin
## /tmp/submin-#{node.build}/INSTALL ############
Submin Installation
-------------------

When installing from tarball, please run:

  python bin/install.py <installdir>

  (Use the '--help' option to get more options)

To install submin in /usr/local, fill in /usr/local for <installdir>. You can
then run /usr/local/bin/submin-admin to create your submin project (multiple
seperate projects are possible). This program will show some help, but for a
quick start, just run:

  /usr/local/bin/submin-admin create default

and it will create files in /etc/submin, /var/lib/submin. Please note that
you have to include one of the generated apache files in /etc/submin/ to your
apache2 config. You can use the "Include" directive for that if you want
to include it in only a specific virtual host.

Then restart apache, go to http://[your webserver]/submin, and log in as user
admin with password admin.

If any instructions are not clear, please file a bug (see 'development' on the
website).
## sudo submin-admin create default #############
/usr/local/share/submin/lib/config/authz/md5crypt.py:10: DeprecationWarning: the md5 module is deprecated; use hashlib instead
  import md5

Apache files created:
   /etc/submin/default-apache-wsgi.conf
   /etc/submin/default-apache-cgi.conf

   Please include one of these in your apache config. Also make sure that
   you have mod_dav_svn and mod_authz_svn enabled.

Created submin configuration with default user admin (password: admin)
#################################################
=end
