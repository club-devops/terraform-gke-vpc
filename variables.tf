variable "name" {
  description = "Network name"
}

variable "project_id" {
  description = "Project Id"
}

variable "region" {
  description = "Network region"
  default     = "europe-west1"
}

variable "description" {
  description = "Network description"
  default     = "K8s cluster network"
}

variable "subnetwork" {
  description = "The name of the Google Compute Engine network subnetwork"
  default     = "cluster-subnetwork"
}

variable "nodes_network" {
  description = "Network ip range"
  default     = "10.50.25.0/24"
}

variable "pods_network" {
  description = "Pod network"
  default = "10.50.128.0/18"
}

variable "services_network" {
  description = "Services network"
  default = "10.50.192.0/18"

}

