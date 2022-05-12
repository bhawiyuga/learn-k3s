# Learn k3s

Repositori kode untuk belajar pengelolaan kluster kubernetes menggunakan platform ``k3s``.

## Direktori Repository

1. ``ansible``
Direktori berisi konfigurasi kluster ``k3s`` menggunakan Ansible. Buat file ``inventory.yaml`` berdasarkan contoh pada file ``inventory-example.yaml``. File ``inventory.yaml`` akan dapat di-generate menggunakan Terraform.

2. ``k3s``
Direktori berisi contoh script untuk konfigurasi cluster ``k3s``.

3. ``kube-example``
Direktori berisi contoh deployment service Kubernetes.

4. ``lima``
Direktori berisi template provisioning instance VM menggunakan ``lima`` (MacOS).

5. ``terraform``
Direktori berisi template provisioning instance AWS EC2 menggunakan ``terraform``.