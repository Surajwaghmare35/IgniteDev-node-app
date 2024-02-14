terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      # version = "1.14.0"
    }
  }
}

provider "kubectl" {
  # Configuration options
  config_path = "./kind-kubeconfig.yaml"
}

resource "kubectl_manifest" "my_node_app" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ignitedev-node-deploy
  labels:
    app: MyExampleApp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: MyExampleApp
  template:
    metadata:
      labels:
        app: MyExampleApp
    spec:
      containers:
      - name: ignitedev-node-app
        image: surajwaghmare35/ignitedev-node-app:latest
        ports:
        - containerPort: 3000
YAML
}

resource "kubectl_manifest" "monitoring" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: monitoring
YAML
}


# provider "kubernetes" {
#   config_path = "./kind-kubeconfig.yaml"
# }

# resource "kubernetes_deployment" "my_node_app" {
#   metadata {
#     name = "ignitedev-node-deploy"
#     labels = {
#       test = "MyExampleApp"
#     }
#   }
#   spec {
#     replicas = 1
#     selector {
#       match_labels = {
#         test = "MyExampleApp"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           test = "MyExampleApp"
#         }
#       }
#       spec {
#         container {
#           image = "surajwaghmare35/ignitedev-node-app:latest"
#           name  = "ignitedev-node-app"
#           port {
#             container_port = 3000
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_namespace" "monitoring" {
#   metadata {
#     name = "monitoring"
#   }
# }

provider "helm" {
  kubernetes {
    config_path = "./kind-kubeconfig.yaml"
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  # namespace  = kubernetes_namespace.monitoring.metadata.0.name
  namespace = kubectl_manifest.monitoring.name
}
