
package "jenkins" do
	action :install
end

service "jenkins" do
	action [:enable, :start]
end
