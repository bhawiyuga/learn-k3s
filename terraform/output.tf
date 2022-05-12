resource "local_file" "AnsibleInventory" {
    filename = "../ansible/inventory.yaml"
    content = templatefile("inventory.tmpl",
        {
            master_instance = aws_instance.master,
            worker_instances = aws_instance.worker
            username = "ubuntu"
        }
    )
}