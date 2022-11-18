terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.43.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_key_filename)
  project     = var.project
  region      = var.region
}
