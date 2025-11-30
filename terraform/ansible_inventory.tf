resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/hosts.tpl", {
    bastion_ip = module.instances.bastion_public_ip
    master_ip  = module.instances.master_private_ip
    worker1_ip = module.instances.worker1_private_ip
    worker2_ip = module.instances.worker2_private_ip
  })
  filename = "${path.module}/../ansible/inventory/hosts"
}
