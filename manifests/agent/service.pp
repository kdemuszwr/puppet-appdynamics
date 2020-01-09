# == Class: appdynamics::agent::service
#
class appdynamics::agent::service
(
  $db_agent_enabled
)
{
inherits appdynamics::params

  if $db_agent_enabled {
    service { 'Appdynamics Database Agent':
      ensure    =>  running,
      enable    =>  true,
    }
  }

  service { 'Appdynamics Machine Agent':
    ensure    =>  running,
    enable    =>  true,
    hasstatus =>  false,
  }

}
