output "proxy_public_ips" {
  value = oci_core_instance.proxy[*].public_ip
}
