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
