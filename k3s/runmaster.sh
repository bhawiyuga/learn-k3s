export MASTER_IP=192.168.56.117
export K3S_NODE_NAME=master
export INSTALL_K3S_EXEC="--write-kubeconfig ~/.kube/config --write-kubeconfig-mode 666 --node-external-ip ${MASTER_IP} --tls-san ${MASTER_IP}"
curl -sfL https://get.k3s.io | sh -s -

sudo cat /var/lib/rancher/k3s/server/node-token