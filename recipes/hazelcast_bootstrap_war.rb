## MSP Standard variables for the recipe
log_prefix = "[Cookbook - Hazelcast_Grid_Setup][Recipe - hazelcast_bootstrap_war] : "
domain_dir = node['hazelcast']['domain.dir']
checksum_dir = node['javamsp']['checksum.file.location']
checksum_file_name = "Hazelcast_Grid_Setup.hazelcast_bootstrap_war.checksum"
appUser = node['javamsp']['appusers'][0][0]
appGroup = node['javamsp']['appgroups'][0][0]

## Installing hazelcast-bootstrap-web war
package_loc = node['hazelcast']['hazelcast.bootstrap.war.loc']
package_version = node['hazelcast']['hazelcast.bootstrap.war.version']
package_name = node['hazelcast']['hazelcast.bootstrap.war.name']
package_url = "#{package_loc}/#{package_version}/#{package_name}-#{package_version}.war"

execute "#{log_prefix} Creating checksum file" do
  not_if {File.file?("#{checksum_dir}/#{checksum_file_name}")}
    cwd #{checksum_dir}
    command "touch #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name};chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}"
    action :run
end

execute "#{log_prefix} Calculating checksum" do
    if (File.file?("#{domain_dir}/webapps/#{package_name}.war"))
      cwd "#{domain_dir}/webapps/"
      command "md5sum #{package_name}.war > #{checksum_dir}/#{checksum_file_name}.current; echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}.current;chmod 755 #{checksum_dir}/#{checksum_file_name}.current;chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}.current"
      action :run
    else
      cwd #{checksum_dir}
      command "touch #{checksum_dir}/#{checksum_file_name}.current; chmod 755 #{checksum_dir}/#{checksum_file_name}.current;chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}.current"
      action :run
      
    end
end

execute "#{log_prefix} Validating checksum and installing package" do
  cwd "#{domain_dir}/webapps"
  command "if [ -f \"#{checksum_dir}/#{checksum_file_name}.current\" ] && [ -f \"#{checksum_dir}/#{checksum_file_name}\" ]; then
  echo \"Checksum file present.\";
  if [ \"`cat #{checksum_dir}/#{checksum_file_name}`\" == \"`cat #{checksum_dir}/#{checksum_file_name}.current`\" ] && [ \"\" != \"`cat #{checksum_dir}/#{checksum_file_name}`\" ]; then  
    echo \" Checksum value same. Not installing package.\"
  else
    echo \"Download hazelcast-bootstrap-web\";
    wget #{package_url} --no-check-certificate -O #{package_name}.war
    chown -R #{appUser}:#{appGroup} #{package_name}.war
    chmod 755 #{package_name}.war
    md5sum \"#{package_name}.war\" > #{checksum_dir}/#{checksum_file_name};echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}; chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name}
  fi
  else
    echo \"Checksum file not present.\";
    echo \"Download hazelcast-bootstrap-web\";
    wget #{package_url} --no-check-certificate -O #{package_name}.war
    chown -R #{appUser}:#{appGroup} #{package_name}.war
    chmod 755 #{package_name}.war
    md5sum \"#{package_name}.war\" > #{checksum_dir}/#{checksum_file_name}; echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}; chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name}
  fi
  rm -rf \"#{checksum_dir}/#{checksum_file_name}.current\"
  "
end
