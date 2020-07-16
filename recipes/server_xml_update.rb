## MSP Standard variables for the recipe
log_prefix = "Cookbook - Hazelcast_Grid_Setup, Recipe - server_xml_update : "
domain_dir = node['hazelcast']['domain.dir']

rmiRegistryPortPlatform = node['hazelcast']['jmx.rmiRegistryPortPlatform']
rmiServerPortPlatform = node['hazelcast']['jmx.rmiServerPortPlatform']

## Checking and adding the listener in server.xml
execute "Checking and adding the listener in server.xml" do
  only_if { ::File.file?("#{domain_dir}/conf/server.xml") }
  cwd "#{domain_dir}/conf"
  command "if [ \"\" == \"`grep 'org\.apache\.catalina\.mbeans\.JmxRemoteLifecycleListener' #{domain_dir}/conf/server.xml`\" ]; then
  echo \"Listener not present. Adding the same\"
  sed -i \"/<Service name=\\\"Catalina\\\">/ a <Listener className=\\\"org.apache.catalina.mbeans.JmxRemoteLifecycleListener\\\" rmiRegistryPortPlatform=\\\"#{rmiRegistryPortPlatform}\\\" rmiServerPortPlatform=\\\"#{rmiServerPortPlatform}\\\"/>\" server.xml
  fi
  sed -i 's|scheme=\"http\" proxyPort=\"80\"||' server.xml
  "
  action :run
end
