
directory node['spring-boot']['app_dir'] do
	action :create
end

template "pom.xml" do
	path "#{node['spring-boot']['app_dir']}/pom.xml"
	owner "vagrant"
	group "vagrant"
	mode "0644"
	source "pom.xml_for_spring-boot.erb"
	variables({
		:groupId => node['spring-boot']['groupId'],
		:artifactId => node['spring-boot']['artifactId']
	})
end

=begin
bash "create spring-boot project with maven" do
	cwd node['spring-boot']['project_dir']
	code "mvn archetype:create -DgroupId=com.techscore.spring_boot_sample -DartifactId=spring_boot_sample"
	action :run
	not_if { File.exists?("/usr/local/#{node['maven']['download']['basename']}") }
end
=end
