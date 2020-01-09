# == Class appdynamics::params
#
class appdynamics::params
{
  $agent_types                          =  []
  $java_agent_install_dir               =  '/opt/AppDynamicsPro/JavaAppServerAgent'

  $db_agent_enable                      =  false
  $db_agent_base                        =  '/opt/AppDynamicsPro'
  $db_agent_home                        =  '/DBAgent'
  $db_group                             =  'appdynamics'
  $db_user                              =  'appdynamics'
  $db_app                               =  undef
  $db_tier                              =  undef
  $db_controller_host                   =  undef
  $db_controller_port                   =  80
  $db_controller_ssl_enabled            =  false
  $db_enable_orchestration              =  false
  $db_account_name                      =  undef
  $db_account_access_key                =  undef
  $db_force_agent_registration          =  false
  $db_node_name                         =  undef
  $db_agent_options                     =  undef
  $db_application_home                  =  undef

  $machine_agent_enable                 =  false
  $machine_agent_base                   =  '/opt/AppDynamicsPro'
  $machine_agent_home                   =  '/MachineAgent'
  $machine_group                        =  'appdynamics'
  $machine_user                         =  'appdynamics'
  $machine_app                          =  undef
  $machine_tier                         =  undef
  $machine_controller_host              =  undef
  $machine_controller_port              =  80
  $machine_controller_ssl_enabled       =  false
  $machine_enable_orchestration         =  false
  $machine_account_name                 =  undef
  $machine_account_access_key           =  undef
  $machine_force_agent_registration     =  false
  $machine_node_name                    =  undef
  $machine_agent_options                =  undef
  $machine_application_home             =  undef

}
