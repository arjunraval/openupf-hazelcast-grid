## MSP Standard variables for the recipe
log_prefix = "[Cookbook - Hazelcast_Grid_Setup][Recipe - startup_script_update] : "
domain_dir = node['hazelcast']['domain.dir']

epf_config_root = node['hazelcast']['epf.config.root']
execute "#{log_prefix} Update Startup script for epf.config.root" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'epf.config.root\' startup.sh`\" ]; then
    echo \"epf.config.root java arg not present. Setting the same. \"
    sed -i '/^TCA_OPTS=/ iHAZELCAST_OPTS=\"-Depf.config.root=#{epf_config_root} \";' startup.sh
else
  echo \"Java Arg epf.config.root already present. Validating value\"
  val=`grep '\\-Depf.config.root' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Depf.config.root.*'|sed \"s|-Depf.config.root=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{epf_config_root}\"
  if [ \"${val}\" == \"#{epf_config_root}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Depf.config.root=${val}|-Depf.config.root=#{epf_config_root}|g\" startup.sh
  fi
fi"
    action :run
end

environment = node['hazelcast']['epf.config.env']
execute "#{log_prefix} Update Startup script for epf.config.env" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'epf.config.env\' startup.sh`\" ]; then
    echo \"epf.config.env java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Depf\.config\.env\=#{environment} \\\";|\" startup.sh
else
  echo \"Java Arg epf.config.env already present. Validating value\"
  val=`grep '\\-Depf.config.env' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Depf.config.env.*'|sed \"s|-Depf.config.env=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{environment}\"
  if [ \"${val}\" == \"#{environment}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Depf.config.env=${val}|-Depf.config.env=#{environment}|g\" startup.sh
  fi
fi"
    action :run
end

mancenterHome = node['hazelcast']['hazelcast.mancenter.home']
execute "#{log_prefix} Update Startup script for hazelcast.mancenter.home" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'hazelcast.mancenter.home\' startup.sh`\" ]; then
echo \"hazelcast.mancenter.home java arg not present. Setting the same. \"
sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dhazelcast\.mancenter\.home\=#{mancenterHome} \\\";|\" startup.sh
else
echo \"Java Arg hazelcast.mancenter.home already present. Validating value\"
val=`grep '\\-Dhazelcast.mancenter.home' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Dhazelcast.mancenter.home.*'|sed \"s|-Dhazelcast.mancenter.home=||g\"`
echo \"Current Value ${val}\"
echo \"Requested Value #{mancenterHome}\"
if [ \"${val}\" == \"#{mancenterHome}\" ]; then
echo \"Argument value same. No update needed\"
else
echo \"Argument value not same. Updating the same\"
sed -i \"s|-Dhazelcast.mancenter.home=${val}|-Dhazelcast.mancenter.home=#{mancenterHome}|g\" startup.sh
fi
fi"
    action :run
end


log4j_configuration = node['hazelcast']['log4j.configuration']
execute "#{log_prefix} Update Startup script for log4j.configuration" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'log4j.configuration\' startup.sh`\" ]; then
    echo \"log4j.configuration java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dlog4j\.configuration\=#{log4j_configuration} \\\";|\" startup.sh
else
  echo \"Java Arg log4j.configuration already present. Validating value\"
  val=`grep '\\-Dlog4j.configuration' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Dlog4j.configuration.*'|sed \"s|-Dlog4j.configuration=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{log4j_configuration}\"
  if [ \"${val}\" == \"#{log4j_configuration}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Dlog4j.configuration=${val}|-Dlog4j.configuration=#{log4j_configuration}|g\" startup.sh
  fi
fi"
    action :run
end

webconsole_type = node['hazelcast']['webconsole.type']
execute "#{log_prefix} Update Startup script for webconsole.type" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'webconsole.type\' startup.sh`\" ]; then
    echo \"webconsole.type java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dwebconsole\.type\=#{webconsole_type} \\\";|\" startup.sh
else
  echo \"Java Arg webconsole.type already present. Validating value\"
  val=`grep '\\-Dwebconsole.type' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Dwebconsole.type.*'|sed \"s|-Dwebconsole.type=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{webconsole_type}\"
  if [ \"${val}\" == \"#{webconsole_type}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Dwebconsole.type=${val}|-Dwebconsole.type=#{webconsole_type}|g\" startup.sh
  fi
fi"
    action :run
end

webconsole_jms_url = node['hazelcast']['webconsole.jms.url']
execute "#{log_prefix} Update Startup script for webconsole.jms.url" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'webconsole.jms.url\' startup.sh`\" ]; then
    echo \"webconsole.jms.url java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dwebconsole\.jms\.url\=#{webconsole_jms_url} \\\";|\" startup.sh
else
  echo \"Java Arg webconsole.jms.url already present. Validating value\"
  val=`grep '\\-Dwebconsole.jms.url' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Dwebconsole.jms.url.*'|sed \"s|-Dwebconsole.jms.url=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{webconsole_jms_url}\"
  if [ \"${val}\" == \"#{webconsole_jms_url}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Dwebconsole.jms.url=${val}|-Dwebconsole.jms.url=#{webconsole_jms_url}|g\" startup.sh
  fi
fi"
    action :run
end

webconsole_jmx_url = node['hazelcast']['webconsole.jmx.url']
execute "#{log_prefix} Update Startup script for webconsole.jmx.url" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'webconsole.jms.url\' startup.sh`\" ]; then
    echo \"webconsole.jmx.url java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dwebconsole\.jmx\.url\=#{webconsole_jmx_url} \\\";|\" startup.sh
else
  echo \"Java Arg webconsole.jmx.url already present. Validating value\"
  val=`grep '\\-Dwebconsole.jmx.url' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Dwebconsole.jmx.url.*'|sed \"s|-Dwebconsole.jmx.url=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{webconsole_jmx_url}\"
  if [ \"${val}\" == \"#{webconsole_jmx_url}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Dwebconsole.jmx.url=${val}|-Dwebconsole.jmx.url=#{webconsole_jmx_url}|g\" startup.sh
  fi
fi"
    action :run
end

webconsole_jmx_user = node['hazelcast']['webconsole.jmx.user']
execute "#{log_prefix} Update Startup script for webconsole.jmx.user" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'webconsole.jmx.user\' startup.sh`\" ]; then
    echo \"webconsole.jmx.user java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dwebconsole\.jmx\.user\=#{webconsole_jmx_user} \\\";|\" startup.sh
else
  echo \"Java Arg webconsole.jmx.user already present. Validating value\"
  val=`grep '\\-Dwebconsole.jmx.user' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Dwebconsole.jmx.user.*'|sed \"s|-Dwebconsole.jmx.user=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{webconsole_jmx_user}\"
  if [ \"${val}\" == \"#{webconsole_jmx_user}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Dwebconsole.jmx.user=${val}|-Dwebconsole.jmx.user=#{webconsole_jmx_user}|g\" startup.sh
  fi
fi"
    action :run
end

webconsole_jmx_password = node['hazelcast']['webconsole.jmx.password']
execute "#{log_prefix} Update Startup script for webconsole.jmx.password" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'webconsole.jmx.password\' startup.sh`\" ]; then
    echo \"webconsole.jmx.password java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dwebconsole\.jmx\.password\=#{webconsole_jmx_password} \\\";|\" startup.sh
else
  echo \"Java Arg webconsole.jmx.password already present. Validating value\"
  val=`grep '\\-Dwebconsole.jmx.password' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Dwebconsole.jmx.password.*'|sed \"s|-Dwebconsole.jmx.password=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{webconsole_jmx_password}\"
  if [ \"${val}\" == \"#{webconsole_jmx_password}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Dwebconsole.jmx.password=${val}|-Dwebconsole.jmx.password=#{webconsole_jmx_password}|g\" startup.sh
  fi
fi"
    action :run
end

execute "#{log_prefix} Update Startup script for com.sun.management.jmxremote" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'com.sun.management.jmxremote \' startup.sh`\" ]; then
    echo \"com.sun.management.jmxremote java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dcom\.sun\.management\.jmxremote \\\";|\" startup.sh
else
  echo \"Java Arg com.sun.management.jmxremote already present.\"
fi"
    action :run
end

jmxremote_port = node['hazelcast']['com.sun.management.jmxremote.port']
execute "#{log_prefix} Update Startup script for com.sun.management.jmxremote.port" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'com.sun.management.jmxremote.port\' startup.sh`\" ]; then
    echo \"com.sun.management.jmxremote.port java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dcom\.sun\.management\.jmxremote\.port\=#{jmxremote_port} \\\";|\" startup.sh
else
  echo \"Java Arg com.sun.management.jmxremote.port already present. Validating value\"
  val=`grep '\\-Dcom.sun.management.jmxremote.port' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Dcom.sun.management.jmxremote.port.*'|sed \"s|-Dcom.sun.management.jmxremote.port=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{jmxremote_port}\"
  if [ \"${val}\" == \"#{jmxremote_port}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Dcom.sun.management.jmxremote.port=${val}|-Dcom.sun.management.jmxremote.port=#{jmxremote_port}|g\" startup.sh
  fi
fi"
    action :run
end

jmxremote_authenticate = node['hazelcast']['com.sun.management.jmxremote.authenticate']
execute "#{log_prefix} Update Startup script for com.sun.management.jmxremote.authenticate" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'com.sun.management.jmxremote.authenticate\' startup.sh`\" ]; then
    echo \"com.sun.management.jmxremote.authenticate java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dcom\.sun\.management\.jmxremote\.authenticate\=#{jmxremote_authenticate} \\\";|\" startup.sh
else
  echo \"Java Arg com.sun.management.jmxremote.authenticate already present. Validating value\"
  val=`grep '\\-Dcom.sun.management.jmxremote.authenticate' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Dcom.sun.management.jmxremote.authenticate.*'|sed \"s|-Dcom.sun.management.jmxremote.authenticate=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{jmxremote_authenticate}\"
  if [ \"${val}\" == \"#{jmxremote_authenticate}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Dcom.sun.management.jmxremote.authenticate=${val}|-Dcom.sun.management.jmxremote.authenticate=#{jmxremote_authenticate}|g\" startup.sh
  fi
fi"
    action :run
end

jmxremote_ssl = node['hazelcast']['com.sun.management.jmxremote.ssl']
execute "#{log_prefix} Update Startup script for com.sun.management.jmxremote.ssl" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'com.sun.management.jmxremote.ssl\' startup.sh`\" ]; then
    echo \"com.sun.management.jmxremote.ssl java arg not present. Setting the same. \"
    sed -i \"/^HAZELCAST_OPTS\=/ s|\\\".$| \-Dcom\.sun\.management\.jmxremote\.ssl\=#{jmxremote_ssl} \\\";|\" startup.sh
else
  echo \"Java Arg com.sun.management.jmxremote.ssl already present. Validating value\"
  val=`grep '\\-Dcom.sun.management.jmxremote.ssl' startup.sh|tr -s \" \" \"\\n\"|grep -o '\\-Dcom.sun.management.jmxremote.ssl.*'|sed \"s|-Dcom.sun.management.jmxremote.ssl=||g\"`
  echo \"Current Value ${val}\"
  echo \"Requested Value #{jmxremote_ssl}\"
  if [ \"${val}\" == \"#{jmxremote_ssl}\" ]; then
    echo \"Argument value same. No update needed\"
  else
    echo \"Argument value not same. Updating the same\"
    sed -i \"s|-Dcom.sun.management.jmxremote.ssl=${val}|-Dcom.sun.management.jmxremote.ssl=#{jmxremote_ssl}|g\" startup.sh
  fi
fi"
    action :run
end


execute "#{log_prefix} Update Startup script" do
  only_if {:: File.file?("#{domain_dir}/bin/startup.sh")}
    cwd "#{domain_dir}/bin"
    command "if [ \"\" == \"`grep \'^CATALINA_OPTS\' startup.sh|grep 'HAZELCAST_OPTS'`\" ]; then
    echo \"Updating CATALINA OPTS to add HAZELCAST_OPTS parameter\"
    sed -i \"/^CATALINA_OPTS=\\\"\\${JAVA_OPTS/ s/\\\".$/ \\${HAZELCAST_OPTS\} \\\";/\" startup.sh
  else
    echo \"CATALINA OPTS has HAZELCAST_OPTS parameter\"
    echo \"No update needed.\"
  fi"  
    action :run
end
