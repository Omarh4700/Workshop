[masters]
master ansible_host=${master_ip} new_hostname=master

[workers]
worker1 ansible_host=${worker1_ip} new_hostname=worker1
worker2 ansible_host=${worker2_ip} new_hostname=worker2

[k8s:children]
masters
workers

[k8s:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=../terraform/bastion-key.pem
ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q ubuntu@${bastion_ip} -i ../terraform/bastion-key.pem -o StrictHostKeyChecking=no"'
