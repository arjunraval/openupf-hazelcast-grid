domain_dir = node['hazelcast']['domain.dir']

template "#{domain_dir}/appConfig/hazelcast-config/upf-hazelcast-external-cache-config.xml" do
  source "upf-hazelcast-external-cache-config.xml.erb"
  owner #{appUser}
  group #{appGroup}
  mode "0750"
  action :create
  not_if { ::File.file?("#{domain_dir}/appConfig/hazelcast-config/upf-hazelcast-external-cache-config.xml") }
  end