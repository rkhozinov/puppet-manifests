class puppet::params {
  $allowed_ips = [
    '172.18.0.0/16',       # Mirantis internal network
    '91.218.144.129/32',   # moscow uplink
    'build1.fuel-infra.org',
    'mirror1.fuel-infra.org'
  ]

  $config = '/etc/puppet/puppet.conf'

  $master_packages = [
    'puppetmaster'
  ]

  $master_service = 'puppetmaster'

  $packages = [
    'puppet',
  ]

  $server = 'fuel-puppet.mirantis.com'

  $service = 'puppet'
}
