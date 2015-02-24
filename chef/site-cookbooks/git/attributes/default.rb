default['git']['install_user_name']     = "git"
default['git']['install_user_password'] = "change_on_first_login"
default['git']['install_user_home']     = "/var/#{default['git']['install_user_name']}"
default['git']['repositories'] = %W[
	sample.git
]
default['git']['remote_users_with_local_account'] = %W[
	vagrant
]
default['git']['remote_users_with_rsa_pub_key'] = %W[
]
