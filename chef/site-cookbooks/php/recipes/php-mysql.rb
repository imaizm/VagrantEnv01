%w[
	php-mysql
].each do |pkg|
	package "#{pkg}" do
		action :install
#		options '--enablerepo=remi'
	end
end

