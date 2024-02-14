#!/bin/bash

# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.21.0/kind-linux-amd64
# For ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.21.0/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Create kind cluster
kind create cluster

# Save kubeconfig to a safe location, here at tf-setup dir.
kind get kubeconfig > ~/kind-kubeconfig.yaml

#mv ~/kind-kubeconfig.yaml /path/to/safei/location/kind-kubeconfig.yaml
