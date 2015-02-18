
directory node['spring-boot']['app_dir'] do
	recursive true
	action :create
end

# mvn -B archetype:generate -DgroupId=<groupId> -DartifactId=<artifactId> -Dversion=1.0.0 -DarchetypeArtifactId=maven-archetype-quickstart
template "pom.xml" do
	path "#{node['spring-boot']['app_dir']}/pom.xml"
	owner "vagrant"
	group "vagrant"
	mode "0644"
	source "pom.xml_for_spring-boot.erb"
	variables({
		:groupId => node['spring-boot']['groupId'],
		:artifactId => node['spring-boot']['artifactId'],
		:versionOfSpringBoot => node['spring-boot']['version']
	})
end

bash "package spring-boot project with maven" do
	cwd node['spring-boot']['app_dir']
	code  <<-EOS
		source /etc/profile
		mvn package
	EOS
	action :run
end
