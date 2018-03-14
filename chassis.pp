$openssl_config = sz_load_config()

openssl::certificate::x509 { $fqdn:
  country      => 'CH',
  organization => 'Example.com',
  commonname   => $fqdn,
  altnames     => $openssl_config[hosts],
  cnf_tpl      => 'openssl-nginx/cert.cnf.erb',
  days         => 3650
} ->
file { "/vagrant/${fqdn}.cert":
	ensure => present,
	source => "/etc/ssl/certs/${fqdn}.crt",
	mode => '0644',
}

include ::openssl-nginx
