
package "java-" + node["openjdk"]["yum_version"] + "-openjdk-devel" do
	action :install
end

bash "Create /etc/profile.d/set_JAVA_HOME.sh" do
	code  <<-EOS
		echo "JAVA_HOME="$(readlink $(readlink $(which javac)) | sed -e "s/\\/bin\\/javac//") > /etc/profile.d/set_JAVA_HOME.sh
	EOS
	action :run
	not_if { File.exists?("/etc/profile.d/set_JAVA_HOME.sh") }
end

template "sudoers_for_java.sh" do
	path "/etc/sudoers.d/sudoers_for_java.sh"
	owner "root"
	group "root"
	mode "0440"
	source "sudoers_for_java.sh.erb"
end
