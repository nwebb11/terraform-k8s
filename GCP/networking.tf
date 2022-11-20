#resource "google_compute_network" "vpc_network" {
#  name                    = "terraform-network"
#  auto_create_subnetworks = "false"
#}

#resource "google_compute_address" "static_ip" {
#  name = "instance-ip"
#}

resource "google_compute_network" "main" {
  name                    = var.name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  name          = var.name
  ip_cidr_range = var.cidr
  network       = google_compute_network.main.self_link
  region        = var.region
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.main.name
  target_tags   = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_https" {
  name          = "allow-https"
  network       = google_compute_network.main.name
  target_tags   = ["allow-https"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}
