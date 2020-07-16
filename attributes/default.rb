# JavaMSP Attributes
default['javamsp']['checksum.file.location'] = "/prod/msp/checksum"
default['javamsp']['appname'] = "app"
default['javamsp']['appusers'] = [["jmapp",-1,"gjmapp",["gjmspsys"],"/prod/users/gjmapp/jmapp","/bin/bash"]]
default['javamsp']['appgroups'] = [["gjmapp",-1]]
default['hazelcast']['domain.dir'] ="/prod/msp/domains/#{node['javamsp']['appname']}_domains/msp_#{node['javamsp']['appname']}_tomcat_02"

# Open UPF Attribute
default['openupf']['epf.config.env'] = "dev"

#Search role name
default['hazelcast']['role'] = "Hazelcast"

# Hazelcast Attributes
default['hazelcast']['grid.master.host'] = "127.0.0.1"
default['hazelcast']['grid.master.port'] = "11410"
default['hazelcast']['cache.port'] = "11415"

# Hazelcast Spring Jar
default['hazelcast']['hazelcast-spring.jar.loc'] = "https://check-mike-check.com/mother/content/groups/Releases/com/hazelcast/hazelcast-spring"
default['hazelcast']['hazelcast-spring.jar.name'] = "hazelcast-spring"
default['hazelcast']['hazelcast-spring.jar.version'] = "3.2.3"

# Hazelcast Jar
default['hazelcast']['hazelcast.jar.loc'] = "https://check-mike-check.com/mother/content/groups/Releases/com/hazelcast/hazelcast"
default['hazelcast']['hazelcast.jar.name'] = "hazelcast"
default['hazelcast']['hazelcast.jar.version'] = "3.2.3"

# Hazelcast Bootstrap War
default['hazelcast']['hazelcast.bootstrap.war.loc'] = "https://check-mike-check.com/mother/content/groups/Releases/com/capitalone/upf/openupf/hazelcast-bootstrap3/openupf-hazelcast-bootstrap-web"
default['hazelcast']['hazelcast.bootstrap.war.name'] = "openupf-hazelcast-bootstrap-web"
default['hazelcast']['hazelcast.bootstrap.war.version'] = "02.01.00.00"

# Hazelcast Mancenter War
default['hazelcast']['hazelcast.mancenter.war.loc'] = "https://check-mike-check.com/mother/content/groups/Releases/com/hazelcast/hazelcast-mancenter"
default['hazelcast']['hazelcast.mancenter.war.name'] = "hazelcast-mancenter"
default['hazelcast']['hazelcast.mancenter.war.version'] = "3.2.3"

# OpenUPF Hazelcast Bootstrap Config
default['hazelcast']['openupf.hazelcast.bootstrap.config.jar.loc'] = "https://check-mike-check.com/mother/content/groups/Releases/com/capitalone/upf/openupf/hazelcast-bootstrap3/openupf-hazelcast-bootstrap-config"
default['hazelcast']['openupf.hazelcast.bootstrap.config.jar.name'] = "openupf-hazelcast-bootstrap-config"
default['hazelcast']['openupf.hazelcast.bootstrap.config.jar.version'] = "02.01.00.00"

# Log4j
default['hazelcast']['log4j.jar.loc'] = "https://check-mike-check.com/mother/content/groups/Releases/log4j/log4j"
default['hazelcast']['log4j.jar.name'] = "log4j"
default['hazelcast']['log4j.jar.version'] = "1.2.16"

# slf4j api jar
default['hazelcast']['slf4j.api.jar.loc'] = "https://check-mike-check.com/mother/content/groups/Releases/org/slf4j/slf4j-api"
default['hazelcast']['slf4j.api.jar.name'] = "slf4j-api"
default['hazelcast']['slf4j.api.jar.version'] = "1.6.4"

# Tomcat Remote JMX Jar
default['hazelcast']['tomcat.remote.jmx.jar.loc'] = "https://check-mike-check.com/mother/content/groups/Eval/org/apache/tomcat/tomcat-catalina-jmx-remote"
default['hazelcast']['tomcat.remote.jmx.jar.name'] = "tomcat-catalina-jmx-remote"
default['hazelcast']['tomcat.remote.jmx.jar.version'] = "7.0.42"

# Hazelcast Java args
default['hazelcast']['epf.config.env'] = "dev"
default['hazelcast']['epf.config.root'] = "\\${CATALINA_BASE}/appConfig"
default['hazelcast']['hazelcast.mancenter.home'] = "\\${CATALINA_BASE}/mancenter"
default['hazelcast']['log4j.configuration'] = "file\:\\${CATALINA_BASE}/appConfig/logging/log4j.xml"
default['hazelcast']['webconsole.type'] = "properties"
default['hazelcast']['webconsole.jms.url'] = "tcp\://localhost\:11413"
default['hazelcast']['webconsole.jmx.url'] = "service\:jmx\:rmi\:///jndi/rmi\://localhost\:11414/jmxrmi"
default['hazelcast']['webconsole.jmx.user'] = "system"
default['hazelcast']['webconsole.jmx.password'] = "manager"
default['hazelcast']['com.sun.management.jmxremote.authenticate'] = "false"
default['hazelcast']['com.sun.management.jmxremote.ssl'] = "false"
default['hazelcast']['jmx.rmiRegistryPortPlatform'] = "11417"
default['hazelcast']['jmx.rmiServerPortPlatform'] = "11416"
default['hazelcast']['com.sun.management.jmxremote.port'] = "11414"
