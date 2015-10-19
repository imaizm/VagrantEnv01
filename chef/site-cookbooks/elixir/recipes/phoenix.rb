#
# Cookbook Name:: elixir
# Recipe:: phoenix
#
bash 'install Phoenix by mix' do
	action :run
	code <<-EOS
		mix archive.install https://github.com/phoenixframework/phoenix/releases/download/v1.0.3/phoenix_new-1.0.3.ez
	EOS
end
