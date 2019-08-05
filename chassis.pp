$openssl_config = sz_load_config()

openssl::certificate::x509 { $fqdn:
  country      => 'CH',
  organization => 'Example.com',
  commonname   => $fqdn,
  altnames     => $openssl_config[hosts],
  extkeyusage  => [ 'serverAuth', 'clientAuth' ],
  cnf_tpl      => 'openssl-nginx/cert.cnf.erb',
  days         => 3650,
  owner        => 'www-data',
  group        => 'www-data',
} ->
file { "/vagrant/${fqdn}.cert":
  ensure => present,
  source => "/etc/ssl/certs/${fqdn}.crt",
  mode => '0644',
}
file { "/vagrant/${fqdn}.key":
  ensure => present,
  source => "/etc/ssl/certs/${fqdn}.key",
  mode => '0644',
}

include ::openssl-nginx
