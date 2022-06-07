resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tftpl",
    {
      proxy_public_ip = oci_core_instance.proxy[0].public_ip
    }
  )
  filename = "${path.module}/generated/proxy.ini"
}
