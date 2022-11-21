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
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_https" {
  name          = "allow-https"
  network       = google_compute_network.main.name
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}

resource "google_compute_firewall" "servers-out" {
  name    = "${var.name}-servers-out"
  network = google_compute_network.main.name
  direction = "EGRESS"
  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "servers-in" {
  name    = "${var.name}-servers-in"
  network = google_compute_network.main.name
  allow {
    protocol = "all"
  }

  source_ranges = [
    var.cidr,

    format("%s/32",google_compute_instance.vm_instance_control[0].network_interface[0].access_config[0].nat_ip),
    format("%s/32",google_compute_instance.vm_instance_control[1].network_interface[0].access_config[0].nat_ip),
    format("%s/32",google_compute_instance.vm_instance_control[2].network_interface[0].access_config[0].nat_ip),
    format("%s/32",google_compute_instance.vm_instance_worker[0].network_interface[0].access_config[0].nat_ip),
    format("%s/32",google_compute_instance.vm_instance_worker[1].network_interface[0].access_config[0].nat_ip),
    format("%s/32",google_compute_instance.vm_instance_worker[2].network_interface[0].access_config[0].nat_ip)
  ]
}
