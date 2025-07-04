locals {
  resolved_cluster_name = var.cluster_name != "" ? var.cluster_name : "tsp-cluster-${terraform.workspace}"
}
