#Default - Cookbook for all calls

checksum_dir = node['javamsp']['checksum.file.location']
log_prefix = "[Cookbook - openupf_hazelcast_grid][Recipe - default] : "
appUser = node['javamsp']['appusers'][0][0]
appGroup = node['javamsp']['appgroups'][0][0]

execute "#{log_prefix} Check/Create checksum dir" do
  not_if {::File.directory?(checksum_dir)}
  command "mkdir -p #{checksum_dir}; chmod -R 777 #{checksum_dir};chown -R #{appUser}:#{appGroup} #{checksum_dir}"
  action :run

end


package_version = node['hazelcast']['hazelcast-spring.jar.version']
if (package_version.chomp == "2.6.7")
  include_recipe "openupf_hazelcast_grid::hazelcast_spring_jar"
end

include_recipe "openupf_hazelcast_grid::domain_properties"
include_recipe "openupf_hazelcast_grid::hazelcast_bootstrap_war"
include_recipe "openupf_hazelcast_grid::hazelcast_mancenter_war"
include_recipe "openupf_hazelcast_grid::openupf_hazelcast_bootstrap_config"
include_recipe "openupf_hazelcast_grid::hazelcast_config_xml"
include_recipe "openupf_hazelcast_grid::log4j"
include_recipe "openupf_hazelcast_grid::slf4j_api_jar"
include_recipe "openupf_hazelcast_grid::tomcat_remote_jmx_jar"
include_recipe "openupf_hazelcast_grid::startup_script_update"
include_recipe "openupf_hazelcast_grid::server_xml_update"
