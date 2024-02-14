Note: This repo code works on ubuntu/linux

    1) Clone https repo locally 
    2) Make sure u have docker, terraform, kubectl install locally on machine
    3) execute, "bash kindLocalCluster.sh" 
    4) copy "kind-kubeconfig.yaml" from ~ to tf-setup directory. 
    5) cd to "tf-setup" directory
    6) execute, "terraform init --upgrade && terraform fmt && terraform validate"
    7) execute, "terraform plan && terraform apply -–auto-approve"

To acess node-app, prometheus, grfana by exposing svc/deploy as:

    • kubectl port-forward deployments/ignitedev-node-deploy --address 0.0.0.0 3000
      
    • kubectl port-forward -n monitoring services/kube-prometheus-stack-prometheus --address 0.0.0.0 9090
      
    • kubectl port-forward -n monitoring deployments/kube-prometheus-stack-grafana --address 0.0.0.0 3000

now on browser type http://localhost:{port}
