## MSP Standard variables for the recipe
log_prefix = "[Cookbook - Hazelcast_Grid_Setup][Recipe - openupf_hazelcast_bootstrap_config] : "
checksum_dir = node['javamsp']['checksum.file.location']
checksum_file_name = "Hazelcast_Grid_Setup.openupf_hazelcast_bootstrap_config.checksum"
appUser = node['javamsp']['appusers'][0][0]
appGroup = node['javamsp']['appgroups'][0][0]

## Path to the domain directory on the server
domain_dir = node['hazelcast']['domain.dir']

## Installing Open UPF Hazelcast Bootstrap Config
package_loc = node['hazelcast']['openupf.hazelcast.bootstrap.config.jar.loc']
package_version = node['hazelcast']['openupf.hazelcast.bootstrap.config.jar.version']
package_name = node['hazelcast']['openupf.hazelcast.bootstrap.config.jar.name']
package_url = "#{package_loc}/#{package_version}/#{package_name}-#{package_version}.jar"


execute "#{log_prefix} Creating checksum file" do
  not_if {File.file?("#{checksum_dir}/#{checksum_file_name}")}
    cwd #{checksum_dir}
    command "cd #{checksum_dir} ; touch #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name}; chown -R #{appUser}:#{appGroup} #{checksum_file_name}"
    action :run
end

execute "#{log_prefix} Calculating checksum" do
    if (File.directory?("#{domain_dir}/appConfig/openupf-hazelcast-bootstrap-web"))
      cwd #{checksum_dir}
      command "cd #{checksum_dir}; find #{domain_dir}/appConfig/openupf-hazelcast-bootstrap-web -type f -exec md5sum {} \\; | sort -k 34 | md5sum > #{checksum_dir}/#{checksum_file_name}.current; echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}.current; chmod 755 #{checksum_dir}/#{checksum_file_name}.current; chown -R #{appUser}:#{appGroup} #{checksum_file_name}.current"
      action :run
    else
      cwd #{checksum_dir}
      command "cd #{checksum_dir}; touch #{checksum_dir}/#{checksum_file_name}.current; chmod 755 #{checksum_dir}/#{checksum_file_name}.current; chown -R #{appUser}:#{appGroup} #{checksum_file_name}.current"
      action :run
      
    end
end

execute "#{log_prefix} Validating checksum and installing package" do
  cwd "#{domain_dir}/appConfig"
  command "if [ -f \"#{checksum_dir}/#{checksum_file_name}.current\" ] && [ -f \"#{checksum_dir}/#{checksum_file_name}\" ]; then
  echo \"Checksum file present.\";
  if [ \"`cat #{checksum_dir}/#{checksum_file_name}`\" == \"`cat #{checksum_dir}/#{checksum_file_name}.current`\" ] && [ \"\" != \"`cat #{checksum_dir}/#{checksum_file_name}`\" ]; then  
    echo \" Checksum value same. Not installing package.\"
  else
    wget #{package_url} --no-check-certificate -O #{package_name}-#{package_version}.jar
    chown -R #{appUser}:#{appGroup} #{package_name}-#{package_version}.jar
  fi
  else
    echo \"Checksum file not present.\";
    wget #{package_url} --no-check-certificate -O #{package_name}-#{package_version}.jar
    chown -R #{appUser}:#{appGroup} #{package_name}-#{package_version}.jar
  fi
  rm -rf \"#{checksum_dir}/#{checksum_file_name}.current\"
  "
end

execute "#{log_prefix} Clean extract openupf-hazelcast-bootstrap-web" do
  only_if {:: File.file?("#{domain_dir}/appConfig/#{package_name}-#{package_version}.jar")}
    cwd "#{domain_dir}/appConfig"
    command "rm -rf #{domain_dir}/appConfig/openupf-hazelcast-bootstrap-web;unzip #{package_name}-#{package_version}.jar;chown -R #{appUser}:#{appGroup} #{domain_dir}/appConfig/openupf-hazelcast-bootstrap-web;rm -rf #{package_name}-#{package_version}.jar META-INF settings #{checksum_dir}/#{checksum_file_name}.current ;find #{domain_dir}/appConfig/openupf-hazelcast-bootstrap-web -type f -exec md5sum {} \\; | sort -k 34 | md5sum > #{checksum_dir}/#{checksum_file_name};echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name};chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}"
    action :run
end   
