## MSP Standard variables for the recipe
log_prefix = "[Cookbook - Hazelcast_Grid_Setup][Recipe - log4j] : "
domain_dir = node['hazelcast']['domain.dir']
checksum_dir = node['javamsp']['checksum.file.location']
checksum_file_name = "Hazelcast_Grid_Setup.log4j.checksum"
appUser = node['javamsp']['appusers'][0][0]
appGroup = node['javamsp']['appgroups'][0][0]


## Installing log4j
package_loc = node['hazelcast']['log4j.jar.loc']
package_version = node['hazelcast']['log4j.jar.version']
package_name = node['hazelcast']['log4j.jar.name']
package_url = "#{package_loc}/#{package_version}/#{package_name}-#{package_version}.jar"

execute "#{log_prefix} Creating checksum file" do
  not_if {File.file?("#{checksum_dir}/#{checksum_file_name}")}
    cwd #{checksum_dir}
    command " touch  #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name}; chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}"
    action :run
end

execute "#{log_prefix} Calculating checksum" do
    if (File.file?("#{domain_dir}/lib/#{package_name}.jar"))
      cwd "#{domain_dir}/lib/"
      command "md5sum #{package_name}.jar > #{checksum_dir}/#{checksum_file_name}.current;echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}.current; chmod 755 #{checksum_dir}/#{checksum_file_name}.current;chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}.current"
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
    echo \"Download log4j\";
    wget #{package_url} --no-check-certificate -O #{package_name}.jar
    chown -R #{appUser}:#{appGroup} #{package_name}.jar
    chmod 755 #{package_name}.jar
    md5sum \"#{package_name}.jar\" > #{checksum_dir}/#{checksum_file_name};echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name};chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}
  fi
  else
    echo \"Checksum file not present.\";
    echo \"Download log4j\";
    wget #{package_url} --no-check-certificate -O #{package_name}.jar
    chown -R #{appUser}:#{appGroup} #{package_name}.jar
    chmod 755 #{package_name}.jar
    md5sum \"#{package_name}.jar\" > #{checksum_dir}/#{checksum_file_name};echo #{package_version} >> #{checksum_dir}/#{checksum_file_name}; chmod 755 #{checksum_dir}/#{checksum_file_name};chown -R #{appUser}:#{appGroup} #{checksum_dir}/#{checksum_file_name}
  fi
  rm -rf \"#{checksum_dir}/#{checksum_file_name}.current\"
  "
end

execute "Create logging folder" do
  not_if {::File.directory?("#{domain_dir}/appConfig/logging")}
    cwd "#{domain_dir}/appConfig"
    command "mkdir -p logging;chown -R #{appUser}:#{appGroup} logging"
    action :run
end

## Replace ulimit file with template
template "#{domain_dir}/appConfig/logging/log4j.xml" do
  source "log4j.xml.erb"
  owner #{appUser}
  group #{appGroup}
  mode "0750"
  variables({
         :domain_dir => domain_dir.chomp
     })
  action :create
end

