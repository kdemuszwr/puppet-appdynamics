# == Class: appdynamics::agent::config::machine
#
class appdynamics::agent::config::machine
(
  $agent_enable,
  $agent_base,
  $appdynamics_home,
  $group,
  $user,
  $app,
  $tier,
  $controller_host,
  $controller_port,
  $controller_ssl_enabled,
  $enable_orchestration,
  $account_name,
  $account_access_key,
  $force_agent_registration,
  $node_name,
  $agent_options,
  $machine_agent_home,
)
{
  inherits appdynamics::params

  file { 'machine_controller-info_xml':
    path    => "${machine_agent_home}/conf/controller-info.xml",
    content => template('appdynamics/agent/machine/controller-info_xml.erb'),
    require => Class['appdynamics::agent::install'],
  } ->

  exec { 'Register Machine Agent as Windows service' :
    command     => "cscript.exe ${machine_agent_home}\\InstallService.vbs",
    provider    => powershell,
    logoutput   => true,
    refreshonly => true,
    notify      => Service['Appdynamics Machine Agent'],
  }
}
