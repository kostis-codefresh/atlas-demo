# aws eks --region us-east-2 update-kubeconfig --name atlas-webinar-mz114dzH
terraform {

  backend "kubernetes" {
    secret_suffix = "common"
    config_path   = "~/.kube/config"
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx_ingress" {
  name = "ingress-nginx"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  version          = "4.6.0"
  create_namespace = true
  set {
    name  = "controller.extraArgs.enable-ssl-passthrough"
    value = ""
  }
}

resource "helm_release" "sealed_secrets" {
  name = "sealed-secrets"

  repository       = "https://bitnami-labs.github.io/sealed-secrets"
  chart            = "sealed-secrets"
  namespace        = "kube-system"
  version          = "2.12.0"
  set {
    name  = "fullnameOverride"
    value = "sealed-secrets-controller"
  }
}