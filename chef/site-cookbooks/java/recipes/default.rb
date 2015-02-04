
package "java-" + node["openjdk"]["yum_version"] + "-openjdk" do
	action :install
end
