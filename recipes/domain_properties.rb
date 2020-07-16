domain_dir = node['hazelcast']['domain.dir']
region_identifier = node['openupf']['region.identifier']
datacenter = node['openupf']['datacenter']

## Replace ulimit file with template
template "#{domain_dir}/appConfig/domain.properties" do
  source "domain.properties.erb"
  owner node['javamsp']['appusers'][0][0]
  group node['javamsp']['appgroups'][0][0]
  mode "0750"
  variables({
                :datacenter => datacenter.chomp,
                :region_identifier => region_identifier.chomp
            })
  action :create
end