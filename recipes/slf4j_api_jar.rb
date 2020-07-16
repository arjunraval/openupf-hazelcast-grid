## MSP Standard variables for the recipe
log_prefix = "[Cookbook - Hazelcast_Grid_Setup][Recipe - slf4j_api_jar] : "
domain_dir = node['hazelcast']['domain.dir']
checksum_dir = node['javamsp']['checksum.file.location']
checksum_file_name = "Hazelcast_Grid_Setup.slf4j_api_jar.checksum"
appUser = node['javamsp']['appusers'][0][0]
appGroup = node['javamsp']['appgroups'][0][0]

## Installing slf4j.api Jar
package_loc = node['hazelcast']['slf4j.api.jar.loc']
package_version = node['hazelcast']['slf4j.api.jar.version']
package_name = node['hazelcast']['slf4j.api.jar.name']
package_url = "#{package_loc}/#{package_version}/#{package_name}-#{package_version}.jar"

execute "#{log_prefix} Creating checksum file" do
  not_if {File.file?("#{checksum_dir}/#{checksum_file_name}")}
    cwd #{checksum_dir}
    command "touch #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name};chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}"
    action :run
end

execute "#{log_prefix} Calculating checksum" do
    if (File.file?("#{domain_dir}/lib/#{package_name}.jar"))
      cwd "#{domain_dir}/lib/"
      command "md5sum #{package_name}.jar > #{checksum_dir}/#{checksum_file_name}.current; echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}.current;chmod 755 #{checksum_dir}/#{checksum_file_name}.current;chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}.current"
      action :run
    else
      cwd #{checksum_dir}
      command "touch #{checksum_dir}/#{checksum_file_name}.current; chmod 755 #{checksum_dir}/#{checksum_file_name}.current;chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}.current"
      action :run
      
    end
end

execute "#{log_prefix} Validating checksum and installing package" do
  cwd "#{domain_dir}/lib"
  command "if [ -f \"#{checksum_dir}/#{checksum_file_name}.current\" ] && [ -f \"#{checksum_dir}/#{checksum_file_name}\" ]; then
  echo \"Checksum file present.\";
  if [ \"`cat #{checksum_dir}/#{checksum_file_name}`\" == \"`cat #{checksum_dir}/#{checksum_file_name}.current`\" ] && [ \"\" != \"`cat #{checksum_dir}/#{checksum_file_name}`\" ]; then  
    echo \" Checksum value same. Not installing package.\"
  else
    echo \"Download slf4j.api\";
    wget #{package_url} --no-check-certificate -O #{package_name}.jar
    chown -R #{appUser}:#{appGroup} #{package_name}.jar
    chmod 755 #{package_name}.jar
    md5sum \"#{package_name}.jar\" > #{checksum_dir}/#{checksum_file_name};echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}; chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name}
  fi
  else
    echo \"Checksum file not present.\";
    echo \"Download slf4j.api\";
    wget #{package_url} --no-check-certificate -O #{package_name}.jar
    chown -R #{appUser}:#{appGroup} #{package_name}.jar
    chmod 755 #{package_name}.jar
    md5sum \"#{package_name}.jar\" > #{checksum_dir}/#{checksum_file_name}; echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}; chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name}
  fi
  rm -rf \"#{checksum_dir}/#{checksum_file_name}.current\"
  "
end
