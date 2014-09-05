# Class: fuel_project::common
#
class fuel_project::common (
  $external_host     = false,
  $ldap              = false,
  $ldap_uri          = '',
  $ldap_base         = '',
  $tls_cacertdir     = '',
  $pam_password      = '',
  $pam_filter        = '',
  $sudoers_base      = '',
  $bind_policy       = '',
  $ldap_ignore_users = '',
) {
  $puppet = hiera_hash('puppet')
  $zabbix = hiera_hash('zabbix')

  include ::dpkg
  class { '::ntp':
    servers  => ['pool.ntp.org'],
    restrict => ['127.0.0.1'],
  }
  class { '::puppet::agent' :
    puppet_server => $puppet['master'],
  }
  include ::ssh::authorized_keys
  include ::ssh::sshd
  include ::system

  if $external_host {
    $firewall = hiera_hash('firewall')

    class { '::zabbix::agent' :
      zabbix_server        => $zabbix['server_external'],
      server_active        => false,
      apply_firewall_rules => true,
    }
  } else {
    class { '::zabbix::agent' :
      zabbix_server => $zabbix['server'],
      server_active => $zabbix['server'],
    }
  }

  if($ldap) {
    class { '::ssh::ldap' :}
  }
}
