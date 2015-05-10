# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = "Env01"
	config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box"

#	config.vm.provider "virtualbox" do |vb|
#		vb.gui = true
#	end

	config.vm.network :private_network, ip:"192.168.33.10"
	config.vm.hostname = "localhost"

	config.vm.network :forwarded_port, guest: 80, host: 10080 # http
	config.vm.network :forwarded_port, guest: 8080, host: 18080 # http
	config.vm.network :forwarded_port, guest: 8082, host: 18082 # http
	config.vm.network :forwarded_port, guest: 8180, host: 18180 # jenkins
	config.vm.network :forwarded_port, guest: 3000, host: 3000 # rails
	config.vm.network :forwarded_port, guest: 3690, host: 3690 # subversion

	config.vm.synced_folder "./src", "/var/www/src", :create => true, :owner => 'vagrant', :group => 'vagrant', :mount_options => ['dmode=777', 'fmode=666']

	if `hostname`.chop == "PJ-DEV-DESK004" then
		config.vm.provider "virtualbox" do |vb|
			vb.customize ["modifyvm", :id, "--memory", "4096"]
		end
	else
		config.vm.provider "virtualbox" do |vb|
			vb.customize ["modifyvm", :id, "--memory", "1024"]
		end
	end

	config.vm.provision "chef_solo" do |chef|
		chef.cookbooks_path = "chef/site-cookbooks/"
		chef.environments_path = "chef/environments/"
		chef.environment = "vagrant"
		chef.run_list = %w[
			recipe[localedef]
			recipe[security-updates::bash-shellshock]
			recipe[node.js]
			recipe[node.js::grunt]
		]
	end

=begin
## all #########################################################################
			recipe[apache]
			recipe[apache::phpms]
			recipe[capistrano]
			recipe[centos::add_yum_repository_jenkins]
			recipe[centos::add_yum_repository_remi]
			recipe[centos::add_yum_repository_wandisco-svn]
			recipe[capistrano]
			recipe[docker]
			recipe[docker::chef-container]
			recipe[docker::tutorial]
			recipe[git]
			recipe[java]
			recipe[java::maven]
			recipe[java::spring-boot_with_maven]
			recipe[jenkins]
			recipe[localedef]
			recipe[mysql]
			recipe[mysql::mysql-latest]
			recipe[mysql::createdb_phpms]
			recipe[node.js]
			recipe[node.js::grunt]
			recipe[php]
			recipe[php::composer]
			recipe[php::composer-laravel]
			recipe[php::php-mysql]
			recipe[php::php-mysqlnd]
			recipe[php::php-with-remi]
			recipe[php-app-phabricator]
			recipe[postfix]
			recipe[rails-app-fulcrum]
			recipe[ruby]
			recipe[ruby::rails]
			recipe[security-updates::bash-shellshock]
			recipe[ssmtp]
			recipe[subversion]
			recipe[subversion-sample]
			recipe[subversion-Submin]
			recipe[yumsetup]
## spring-boot #################################################################
			recipe[localedef]
			recipe[security-updates::bash-shellshock]
			recipe[java]
			recipe[java::maven]
			recipe[java::spring-boot_with_maven]
## jenkins #####################################################################
			recipe[localedef]
			recipe[security-updates::bash-shellshock]
			recipe[java]
			recipe[centos::add_yum_repository_jenkins]
			recipe[jenkins]
## capistrano #########################
			recipe[localedef]
			recipe[security-updates::bash-shellshock]
			recipe[ruby]
			recipe[capstrano]
## docker #############################
			recipe[localedef]
			recipe[security-updates::bash-shellshock]
			recipe[docker]
			recipe[ruby]
			recipe[docker::chef-container]
			recipe[docker::tutorial]
## fulcrum ############################
			recipe[localedef]
			recipe[security-updates::bash-shellshock]
			recipe[ruby]
			recipe[ruby::rails]
			recipe[rails-app-fulcrum]
## phabricator ########################
			recipe[localedef]
			recipe[security-updates::bash-shellshock]
			recipe[apache]
			recipe[mysql::mysql-latest]
			recipe[ssmtp]
			recipe[subversion]
			recipe[subversion-sample]
			recipe[php]
			recipe[php::php-mysql]
			recipe[php-app-phabricator]
## php/laravel ########################
			recipe[localedef]
			recipe[security-updates::bash-shellshock]
			recipe[apache]
			recipe[centos::add_yum_repository_remi]
			recipe[php::php-with-remi]
			recipe[php::composer]
			recipe[php::composer-laravel]
## tutrial/phpms ######################
			recipe[localedef]
			recipe[security-updates::bash-shellshock]
			recipe[apache]
			recipe[mysql]
			recipe[apache::phpms]
			recipe[php]
			recipe[remi]
			recipe[php::php-mysqlnd]
#######################################
=end

	config.omnibus.chef_version = :latest

	config.ssh.forward_x11 = true

end
