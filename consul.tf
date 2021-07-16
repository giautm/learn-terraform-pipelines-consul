resource "helm_release" "consul" {
  count     = data.terraform_remote_state.cluster.outputs.enable_consul_and_vault ? 1 : 0
  name      = "${var.release_name}-consul"
  namespace = var.namespace

  repository = "https://helm.releases.hashicorp.com"
  chart      = "consul"
  version    = "0.32.1"

  depends_on = [
    kubernetes_namespace.secrets
  ]

  set {
    name  = "global.name"
    value = "consul"
  }

  set {
    name  = "server.replicas"
    value = var.replicas
  }

  set {
    name  = "server.bootstrapExpect"
    value = var.replicas
  }
}