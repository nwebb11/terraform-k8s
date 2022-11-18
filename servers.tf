resource "google_compute_instance" "vm_instance_control" {
  count        = length(var.zones)
  name         = "${var.name}-control-${element(var.node_ids, count.index)}"
  machine_type = "e2-highcpu-2"
  zone         = "${var.region}-${element(var.zones, count.index)}"
  tags         = ["allow-ssh"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
      size  = 10
      type = "pd-ssd"
    }
  }

  network_interface {
    #network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.main.name
    access_config {
      #nat_ip = google_compute_address.static_ip.address
    }
  }

  #provisioner "remote-exec" {
    #connection {
      #host        = google_compute_instance.vm_instance[count.index].network_interface[0].access_config[0].nat_ip
      #type        = "ssh"
      #user        = var.ssh_user
      #timeout     = "600s"
      #private_key = file(var.ssh_priv_key)
    #}
    #inline = [
      #"sudo apt update",
      #"sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y",
      #"sudo apt autoremove -y"
    #]
  #}

  depends_on = [google_compute_firewall.allow_ssh]

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key)}"
  }
}

resource "google_compute_instance" "vm_instance_worker" {
  count        = length(var.zones)
  name         = "${var.name}-worker-${element(var.node_ids, count.index)}"
  machine_type = "e2-standard-2"
  zone         = "${var.region}-${element(var.zones, count.index)}"
  tags         = ["allow-ssh"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
      size  = 10
      type = "pd-ssd"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.main.name
    access_config {
    }
  }

  depends_on = [google_compute_firewall.allow_ssh]

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key)}"
  }
}
