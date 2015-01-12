#
# Cookbook Name:: php
# Recipe:: composer
#
bash "Install Composer" do
	cwd "/usr/local/bin/"
	code  <<-EOS
		curl -sS https://getcomposer.org/installer | php
		mv composer.phar composer
	EOS
	action :run
	not_if { File.exists?("/usr/local/bin/composer") }
end
