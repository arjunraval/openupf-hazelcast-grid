# Hazelcast_Grid_Setup Cookbook

This cookbook installs Hazelcast on top of Java MSP Standard Tomcat Instance.
This cookbook should be used by applications looking for Hazelcast cache grid configuration.

## Pre-requisites
- Java MSP Standard Tomcat instance needs to be provisioned

## Attributes
#### Java MSP Attributes
- ```['javamsp']['checksum.file.location']``` - Location where the checksum values are saved for cross verification. Defaut value is /prod/msp/checksum
- ```['javamsp']['appname']``` - Abbrivation representation for the application. Standard is to have maximum of 5 characters. This parameter needs to be overwritten by the app teams. For e.g. Java MSP is jmsp. 
- ```['javamsp']['appuser']``` - System user to be used to install artifacts. User needs to be already available on the host.
- ```['javamsp']['appgroup']``` - Primary group for the system user to be used to install artifacts. Group needs to be available on the host and configured as primary group for the app system user.
- ```['hazelcast']['domain.dir']``` - Location for the domain dir on which configurations need to be applied. Standard location is /prod/msp/domains/<appName>_domains/msp_<appName>_tomcat_02
	
--------------------	
#### Open UPF Attribute
- ```['openupf']['epf.config.env']``` -  Default is dev

--------------------	
#### Hazelcast Attributes
- ``` ['hazelcast']['grid.master.host'] ``` - Default value is  "127.0.0.1"
- ``` ['hazelcast']['grid.master.port'] ``` - Default value is  "11410"
- ``` ['hazelcast']['cache.port'] ``` - Default value is  "11415"

--------------------	
#### Hazelcast Spring Jar
- ``` ['hazelcast']['hazelcast-spring.jar.loc'] ``` - Default value is  "https://check-mike-check.com/mother/content/groups/Releases/com/hazelcast/hazelcast-spring"
- ``` ['hazelcast']['hazelcast-spring.jar.name'] ``` - Default value is  "hazelcast-spring"
- ``` ['hazelcast']['hazelcast-spring.jar.version'] ``` - Default value is  "3.2.3"

--------------------	
#### Hazelcast Jar
- ``` ['hazelcast']['hazelcast.jar.loc'] ``` - Default value is  "https://check-mike-check.com/mother/content/groups/Releases/com/hazelcast/hazelcast"
- ``` ['hazelcast']['hazelcast.jar.name'] ``` - Default value is  "hazelcast"
- ``` ['hazelcast']['hazelcast.jar.version'] ``` - Default value is  "3.2.3"

--------------------	
#### Hazelcast Bootstrap War
- ``` ['hazelcast']['hazelcast.bootstrap.war.loc'] ``` - Default value is  "https://check-mike-check.com/mother/content/groups/Releases/com/capitalone/upf/openupf/hazelcast-bootstrap3/openupf-hazelcast-bootstrap-web"
- ``` ['hazelcast']['hazelcast.bootstrap.war.name'] ``` - Default value is  "openupf-hazelcast-bootstrap-web"
- ``` ['hazelcast']['hazelcast.bootstrap.war.version'] ``` - Default value is  "02.01.00.00"

--------------------	
#### Hazelcast Mancenter War
- ``` ['hazelcast']['hazelcast.mancenter.war.loc'] ``` - Default value is  "https://check-mike-check.com/mother/content/groups/Releases/com/hazelcast/hazelcast-mancenter"
- ``` ['hazelcast']['hazelcast.mancenter.war.name'] ``` - Default value is  "hazelcast-mancenter"
- ``` ['hazelcast']['hazelcast.mancenter.war.version'] ``` - Default value is  "3.2.3"

--------------------	
#### OpenUPF Hazelcast Bootstrap Config
- ``` ['hazelcast']['openupf.hazelcast.bootstrap.config.jar.loc'] ``` - Default value is  "https://check-mike-check.com/mother/content/groups/Releases/com/capitalone/upf/openupf/hazelcast-bootstrap3/openupf-hazelcast-bootstrap-config"
- ``` ['hazelcast']['openupf.hazelcast.bootstrap.config.jar.name'] ``` - Default value is  "openupf-hazelcast-bootstrap-config"
- ``` ['hazelcast']['openupf.hazelcast.bootstrap.config.jar.version'] ``` - Default value is  "02.01.00.00"

--------------------	
#### log4j
- ``` ['hazelcast']['log4j.jar.loc'] ``` - Default value is  "https://check-mike-check.com/mother/content/groups/Releases/log4j/log4j"
- ``` ['hazelcast']['log4j.jar.name'] ``` - Default value is  "log4j"
- ``` ['hazelcast']['log4j.jar.version'] ``` - Default value is  "1.2.16"
--------------------	
#### slf4j api jar
- ``` ['hazelcast']['slf4j.api.jar.loc'] ``` - Default value is  "https://check-mike-check.com/mother/content/groups/Releases/org/slf4j/slf4j-api"
- ``` ['hazelcast']['slf4j.api.jar.name'] ``` - Default value is  "slf4j-api"
- ``` ['hazelcast']['slf4j.api.jar.version'] ``` - Default value is  "1.6.4"

--------------------	
#### Tomcat Remote JMX Jar
- ``` ['hazelcast']['tomcat.remote.jmx.jar.loc'] ``` - Default value is  "https://check-mike-check.com/mother/content/groups/Eval/org/apache/tomcat/tomcat-catalina-jmx-remote"
- ``` ['hazelcast']['tomcat.remote.jmx.jar.name'] ``` - Default value is  "tomcat-catalina-jmx-remote"
- ``` ['hazelcast']['tomcat.remote.jmx.jar.version'] ``` - Default value is  "7.0.42"

--------------------	
#### Hazelcast Java args
- ``` ['hazelcast']['epf.config.env'] ``` - Default value is  "dev"
- ``` ['hazelcast']['epf.config.root'] ``` - Default value is  "\\${CATALINA_BASE}/appConfig"
- ``` ['hazelcast']['log4j.configuration'] ``` - Default value is  "file\:\\${CATALINA_BASE}/appConfig/logging/log4j.xml"
- ``` ['hazelcast']['webconsole.type'] ``` - Default value is  "properties"
- ``` ['hazelcast']['webconsole.jms.url'] ``` - Default value is  "tcp\://localhost\:11413"
- ``` ['hazelcast']['webconsole.jmx.url'] ``` - Default value is  "service\:jmx\:rmi\:///jndi/rmi\://localhost\:11414/jmxrmi"
- ``` ['hazelcast']['webconsole.jmx.user'] ``` - Default value is  "system"
- ``` ['hazelcast']['webconsole.jmx.password'] ``` - Default value is  "manager"
- ``` ['hazelcast']['com.sun.management.jmxremote.authenticate'] ``` - Default value is  "false"
- ``` ['hazelcast']['com.sun.management.jmxremote.ssl'] ``` - Default value is  "false"
- ``` ['hazelcast']['jmx.rmiRegistryPortPlatform'] ``` - Default value is  "11417"
- ``` ['hazelcast']['jmx.rmiServerPortPlatform'] ``` - Default value is  "11416"
- ``` ['hazelcast']['com.sun.management.jmxremote.port'] ``` - Default value is  "11414"


## Recipes
- ```default.rb``` - This acts as a wrapper recipe and includes all required recipes in the correct sequence.
- ``` hazelcast_spring_jar``` - This downloads and manages the hazelcast spring jar
- ``` hazelcast_jar``` - This downloads and manages the hazelcast jar
- ``` hazelcast_bootstrap_war``` - This downloads and installs the hazelcast bootstrap application
- ``` hazelcast_mancenter_war``` - This downloads and installs the management center application for hazelcast grid
- ``` openupf_hazelcast_bootstrap_config``` - This downloads and configures the UPF bootstrap component for hazelcast
- ``` hazelcast_config_xml``` - This creates and maintains the hazelcast config xml
- ``` log4j``` - This downloads and manages log4j jar along with xml configuration
- ``` slf4j_api_jar``` - This downloads and manages slf4j api jar
- ``` tomcat_remote_jmx_jar``` - This downloads and manages tomcat remore JMX jar
- ``` startup_script_update``` - This updates java args for hazelcast in startup script
- ``` server_xml_update``` - This adds listener in server.xml for JMX
