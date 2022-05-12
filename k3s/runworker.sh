export K3S_NODE_NAME=worker1
export K3S_URL="https://192.168.56.117:6443"
export K3S_TOKEN=CHANGEME
curl -sfL https://get.k3s.io | sh -s -