# == Class: appdynamics::agent::config::db
#
class appdynamics::agent::config::db
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
  $db_agent_home,
)
{
  inherits appdynamics::params

  file { 'db_controller-info_xml':
    path    => "${db_agent_home}/conf/controller-info.xml",
    content => template('appdynamics/agent/db/controller-info_xml.erb'),
    require => Class['appdynamics::agent::install'],
  } ->

  exec { 'Register DB Agent as Windows service' :
    command     => "cscript ${db_agent_home}\\InstallService.vbs",
    provider    => powershell,
    logoutput   => true,
    refreshonly => true,
    notify      => Service['Appdynamics Database Agent'],
  }
}
