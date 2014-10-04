%w[
	php
	php-pdo
	php-mbstring
].each do |pkg|
	package "#{pkg}" do
		action :install
	end
end

