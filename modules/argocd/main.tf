resource "helm_release" "argocd" {
  name  = var.helm_release
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.48.0"
  create_namespace = true
  values = [
    file("../../infrastructure/argocd-template/argocd-install.yaml")
  ]
}

resource "helm_release" "apps" {
  name  = "apps"
  repository       = "../../infrastructure/argocd-template"
  chart            = "../../infrastructure/argocd-template"
  namespace        = "argocd"
  values = [
    file("../../infrastructure/argocd-template/values.yaml")
  ]
  depends_on = [
    helm_release.argocd
  ]
}
