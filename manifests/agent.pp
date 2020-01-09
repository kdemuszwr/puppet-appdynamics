# == Class: appdynamics::agent
#
class appdynamics::agent
(
  $db_agent_enable                      =  appdynamics::params::db_agent_enable,
  $db_agent_base                        =  appdynamics::params::db_agent_base,
  $db_agent_home                        =  appdynamics::params::db_agent_home,
  $db_group                             =  appdynamics::params::db_group,
  $db_user                              =  appdynamics::params::db_user,
  $db_app                               =  appdynamics::params::db_app,
  $db_tier                              =  appdynamics::params::db_tier,
  $db_controller_host                   =  appdynamics::params::db_controller_host,
  $db_controller_port                   =  appdynamics::params::db_controller_port,
  $db_controller_ssl_enabled            =  appdynamics::params::db_controller_ssl_enabled,
  $db_enable_orchestration              =  appdynamics::params::db_enable_orchestration,
  $db_account_name                      =  appdynamics::params::db_account_name,
  $db_account_access_key                =  appdynamics::params::db_account_access_key,
  $db_force_agent_registration          =  appdynamics::params::db_force_agent_registration,
  $db_node_name                         =  appdynamics::params::db_node_name,
  $db_agent_options                     =  appdynamics::params::db_agent_options,
  $db_agent_home                        =  appdynamics::params::db_agent_home,

  $machine_agent_enable                 =  appdynamics::params::machine_agent_enable,
  $machine_agent_base                   =  appdynamics::params::machine_agent_base,
  $machine_agent_home                   =  appdynamics::params::machine_agent_home,
  $machine_group                        =  appdynamics::params::machine_group,
  $machine_user                         =  appdynamics::params::machine_user,
  $machine_app                          =  appdynamics::params::machine_app,
  $machine_tier                         =  appdynamics::params::machine_tier,
  $machine_controller_host              =  appdynamics::params::machine_controller_host,
  $machine_controller_port              =  appdynamics::params::machine_controller_port,
  $machine_controller_ssl_enabled       =  appdynamics::params::machine_controller_ssl_enabled,
  $machine_enable_orchestration         =  appdynamics::params::machine_enable_orchestration,
  $machine_account_name                 =  appdynamics::params::machine_account_name,
  $machine_account_access_key           =  appdynamics::params::machine_account_access_key,
  $machine_force_agent_registration     =  appdynamics::params::machine_force_agent_registration,
  $machine_node_name                    =  appdynamics::params::machine_node_name,
  $machine_agent_options                =  appdynamics::params::machine_agent_options,
  $machine_agent_home                   =  appdynamics::params::machine_agent_home,
)
{

  # Validate parameters.

  validate_bool               ($db_agent_enable)
  validate_string             ($db_agent_base)
  validate_string             ($db_agent_home)
  validate_string             ($db_group)
  validate_string             ($db_user)
  validate_string             ($db_app)
  validate_string             ($db_tier)
  validate_string             ($db_controller_host)
  validate_integer            ($db_controller_port)
  validate_bool               ($db_controller_ssl_enabled)
  validate_bool               ($db_enable_orchestration)
  validate_string             ($db_account_name)
  validate_string             ($db_account_access_key)
  validate_bool               ($db_force_agent_registration)
  validate_string             ($db_node_name)
  validate_string             ($db_agent_options)
  validate_string             ($db_agent_home)

  validate_bool               ($machine_agent_enable)
  validate_string             ($machine_agent_base)
  validate_string             ($machine_agent_home)
  validate_string             ($machine_group)
  validate_string             ($machine_app)
  validate_string             ($machine_tier)
  validate_string             ($machine_user)
  validate_string             ($machine_controller_host)
  validate_integer            ($machine_controller_port)
  validate_bool               ($machine_controller_ssl_enabled)
  validate_bool               ($machine_enable_orchestration)
  validate_string             ($machine_account_name)
  validate_string             ($machine_account_access_key)
  validate_bool               ($machine_force_agent_registration)
  validate_string             ($machine_node_name)
  validate_string             ($machine_agent_options)
  validate_string             ($machine_agent_home)

  # Install agent package(s).
  class { 'appdynamics::agent::install': }
  contain 'appdynamics::agent::install'

  # Configure agent(s).

  class { 'appdynamics::agent::config::machine':
    agent_enable             => $machine_agent_enable,
    agent_base               => $machine_agent_base,
    appdynamics_home         => $machine_agent_home,
    group                    => $machine_group,
    user                     => $machine_user,
    app                      => $machine_app,
    tier                     => $machine_tier,
    controller_host          => $machine_controller_host,
    controller_port          => $machine_controller_port,
    controller_ssl_enabled   => $machine_controller_ssl_enabled,
    enable_orchestration     => $machine_enable_orchestration,
    account_name             => $machine_account_name,
    account_access_key       => $machine_account_access_key,
    force_agent_registration => $machine_force_agent_registration,
    node_name                => $machine_node_name,
    agent_options            => $machine_agent_options,
    machine_agent_home       => $machine_agent_home,
  }
  contain 'appdynamics::agent::config::machine'

  class { 'appdynamics::agent::service::machine': }

  if $db_agent_enabled {

    class { 'appdynamics::agent::config::db':
      agent_enable             => $db_agent_enable,
      agent_base               => $db_agent_base,
      appdynamics_home         => $db_agent_home,
      group                    => $db_group,
      user                     => $db_user,
      app                      => $db_app,
      tier                     => $db_tier,
      controller_host          => $db_controller_host,
      controller_port          => $db_controller_port,
      controller_ssl_enabled   => $db_controller_ssl_enabled,
      enable_orchestration     => $db_enable_orchestration,
      account_name             => $db_account_name,
      account_access_key       => $db_account_access_key,
      force_agent_registration => $db_force_agent_registration,
      node_name                => $db_node_name,
      agent_options            => $db_agent_options,
      machine_agent_home       => $db_agent_home,
    }
    contain 'appdynamics::agent::config::db'
  
    class { 'appdynamics::agent::service::db':
      db_agent_enabled => $db_agent_enable,
    }

  }

}
