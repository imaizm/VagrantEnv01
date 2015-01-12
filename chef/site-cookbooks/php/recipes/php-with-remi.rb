%w[
	php
	php-pdo
	php-mbstring
	php-mcrypt
].each do |pkg|
	package "#{pkg}" do
		action :install
		options '--enablerepo=remi'
	end
end

