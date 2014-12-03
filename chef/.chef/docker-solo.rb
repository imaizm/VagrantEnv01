file_cache_path "/tmp/chef-solo"
cookbook_path    ["/chef-repo/cookbooks", "/chef-repo/site-cookbooks"]
node_path        "/chef-repo/nodes"
role_path        "/chef-repo/roles"
environment_path "/chef-repo/environments"
data_bag_path    "/chef-repo/data_bags"
#encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "/chef-repo/cookbooks"
