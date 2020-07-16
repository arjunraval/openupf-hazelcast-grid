## MSP Standard variables for the recipe
log_prefix = "[Cookbook - Hazelcast_Grid_Setup][Recipe - hazelcast_config_xml] : "
domain_dir = node['hazelcast']['domain.dir']
appUser = node['javamsp']['appusers'][0][0]
appGroup = node['javamsp']['appgroups'][0][0]
appName = node['javamsp']['appname']
environment = node['openupf']['epf.config.env']

env_name = node.chef_environment

## Installing hazelcast_config_xml
hazelcast_cache_port = node['hazelcast']['cache.port']
hazelcast_version = node['hazelcast']['hazelcast.jar.version']
grid_master_host = node['hazelcast']['grid.master.host']
grid_master_port = node['hazelcast']['grid.master.port']

execute "Create hazelcast-config folder" do
  not_if {::File.directory?("#{domain_dir}/appConfig/hazelcast-config")}
    cwd "#{domain_dir}/appConfig"
    command "mkdir -p hazelcast-config;chown -R #{appUser}:#{appGroup} hazelcast-config"
    action :run
end

if Chef::Config[:solo]
  Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
else
   hazelcast_servers = search(:node,"role:#{node['hazelcast']['role']} AND chef_environment:#{env_name}" )
end

## Replace ulimit file with template
template "#{domain_dir}/appConfig/hazelcast-config/upf-hazelcast-server-config.xml" do
  source "upf-hazelcast-server-config.xml.#{hazelcast_version}.erb"
  owner #{appUser}
  group #{appGroup}
  mode "0750"
  variables({
                :hazelcast_cache_port => hazelcast_cache_port.chomp,
                :environment => environment.chomp,
                :appName => appName.chomp,
                :grid_master_host =>grid_master_host.chomp,
                :grid_master_port =>grid_master_port.chomp,
                :hazelcast_servers => hazelcast_servers
            })
  action :create
end


if (hazelcast_version != "2.6.7")
  include_recipe "openupf_hazelcast_grid::update_external_cache"
end



execute "Cleanup mancenter and hazelcast spring jars for hazelcast 3.2.3" do
  only_if { hazelcast_version != "2.6.7"}
    cwd #{domain_dir}
    command "cd #{domain_dir}; rm -rf #{domain_dir}/lib/hazelcast-*.jar ~/mancenter"
    action :run
end
