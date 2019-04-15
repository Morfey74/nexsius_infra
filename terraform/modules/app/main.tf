terraform {
  required_version = ">=0.11,<0.12"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  network_interface {
    network       = "default"
    access_config = {
		nat_ip = "${google_compute_address.app_ip.address}"
	}
  }
  
  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = "false"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "../files/puma-server.service"
    destination = "/tmp/puma-server.service"
  }

  provisioner "remote-exec" {
    script = "../files/deploy.sh"
  }
   provisioner "remote-exec" {
    inline = [
      "sudo sed -i 's/#Environment=DATABASE_URL=VALUE/Environment=DATABASE_URL=${var.db_internal_ip}/;' /etc/systemd/system/puma-server.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart puma-server.service",
    ]
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
