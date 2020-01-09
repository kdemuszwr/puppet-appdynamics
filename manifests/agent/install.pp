# == Class::appdynamics::agent::install
#
class appdynamics::agent::install
(
  $appdynamics_home
  $s3_bucket_name
  $db_agent_name
  $machine_agent_name
  $machine_agent_home
  $db_agent_enabled
)
{
inherits appdynamics::params

# install java
#  package { 'jdk8':
#    ensure   => installed,
#    provider => 'chocolatey',
#  }

# create directory
  file { $appdynamics_home:
    ensure  => directory,
  }

  exec { 'Download machine agent':
    command  => "Copy-S3Object -BucketName ${s3_bucket_name} -Key ${machine_agent_name} -LocalFolder ${appdynamics_home}",
    creates  => "C:\\${appdynamics_home}\\${$machine_agent_name}",
    provider =>  'powershell'
    require  => File[$appdynamics_home]
  } ->
  exec { 'unzip machine agent' :
    command   => "Expand-Archive -Path ${appdynamics_home}\\${machine_agent_name} -DestinationPath ${machine_agent_home} -Force",
    provider  => powershell,
    logoutput => true,
    creates   => "${appdynamics_home}\\${machine_agent_name}",
  } ->
  exec { 'register machine agent as windows service' :
    command   => "cscript C:\\${appdynamics_home}\\${db_agent_name}\\bin\\machine-agent.vbs",
    provider  => powershell,
    logoutput => true,
    creates   => "${appdynamics_home}\\${db_agent_name}",
  }

  if $db_agent_enabled {
    exec { 'Download DB agent':
      command  => "Copy-S3Object -BucketName ${s3_bucket_name} -Key ${db_agent_name}.zip -LocalFolder C:\\",
      creates  => "${dappdynamics_homeme}",
      provider =>  'powershell'
      require  => File[$appdynamics_home]
    } ->
    exec { 'unzip db agent' :
      command   => "Expand-Archive -Path ${appdynamics_home}\\${db_agent_name}.zip -DestinationPath ${appdynamics_home} -Force",
      provider  => powershell,
      logoutput => true,
      creates   => "C:\\${appdynamics_home}\\${db_agent_name}",
    } ->
    exec { 'register db agent as windows service' :
      command   => "cscript C:\\${appdynamics_home}\\${db_agent_name}\\InstallService.vbs",
      provider  => powershell,
      logoutput => true,
      creates   => "C:\\${appdynamics_home}\\${db_agent_name}",
    }    

  }

}
