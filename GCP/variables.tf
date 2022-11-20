variable "project" {
  description = "GCP project name"
}

variable "gcp_key_filename" {
  description = "json key file location"
}

variable "name" {
  description = "Name for cloud resources"
}

variable "region" {
  description = "GCP region"
}

variable "zones" {
  type    = list(string)
  default = ["a", "b", "c"]
}

variable "node_ids" {
  type    = list(string)
  default = ["1", "2", "3"]
}

variable "cidr" {
  type    = string
  default = "192.168.100.0/24"
}

variable "ssh_user" {
  type    = string
  default = "terraform"
}

variable "ssh_pub_key" {
  type    = string
  default = "~/.ssh/terraform-gcp-key.pub"
}

variable "ssh_priv_key" {
  type    = string
  default = "~/.ssh/terraform-gcp-key"
}
