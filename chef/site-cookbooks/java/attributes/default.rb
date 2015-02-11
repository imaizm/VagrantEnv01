default["openjdk"]["yum_version"] = "1.8.0"

default["maven"]["download"]["version"]["major"] = "3"
default["maven"]["download"]["version"]["detail"] = "3.2.5"
default["maven"]["download"]["site"] = "http://ftp.kddilabs.jp/infosystems/apache"
default["maven"]["download"]["basename"] = "apache-maven-" + default["maven"]["download"]["version"]["detail"]
default["maven"]["download"]["file"] = default["maven"]["download"]["basename"] + "-bin.tar.gz"
default["maven"]["download"]["url"] = default["maven"]["download"]["site"] + "/maven/maven-" + default["maven"]["download"]["version"]["major"] + "/" + default["maven"]["download"]["version"]["detail"] + "/binaries/" + default["maven"]["download"]["file"]

default['spring-boot']['version'] = "1.2.1.RELEASE"
default['spring-boot']['groupId'] = "org.sample"
default['spring-boot']['artifactId'] = "SampleProject"
default['spring-boot']['apps_basedir'] = "/var/www/src/spring-boot-apps"
default['spring-boot']['app_dir'] = "#{default['spring-boot']['apps_basedir']}/#{default['spring-boot']['artifactId']}"
