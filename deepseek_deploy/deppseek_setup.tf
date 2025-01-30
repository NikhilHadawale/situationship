resource "google_compute_instance" "deepseek-instance" {
  name         = "deepseek-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["allow-ingress", "allow-egress"]
  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2410-amd64"
    }
  }

  network_interface {
    network = "default"
    access_config {
      
    }
  }
  metadata = {
    ssh-keys = "nikhil:${var.ssh_public_key}"
  }
}

resource "google_compute_firewall" "allow_ingress" {
  name    = "allow-ingress"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ingress"]
}

resource "google_compute_firewall" "allow_egress" {
  name    = "allow-egress"
  network = "default"

  direction = "EGRESS"
  allow {
    protocol = "all"
  }
  destination_ranges = ["0.0.0.0/0"]

}

variable "ssh_public_key" {
  description = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClXWkOAN7hsmqI9X9p4srC0dRcK3t9WTUheNks9fs0Ki7CzzBjN68wf/zihbrhw1Swt9uNW4i/Vm3w7IsoR1+yME2I31RAAhLziVBWLk44O7i4SpQycu35F6VEBWuE5a/Cl6ozDu46W+pCgmCuqhEpVdkstptHx6f9R+xEqJ/6VG88ZxEhM+X49lEe7X0pua6KIpSzKwdzNhlcI6rzcO4Rs589r89UBaCFWEcp/3fPcRBCFIsv7GvhVutuVJ1tGueaqR6OIdEWtDHjvYppnWcRK+iLgqTjX6U4xUS7hyUJ/zg/sE8tQ/jzPFp8qMsNddwl/lNTM6bc3M6JwfXRMbMB nikhil@nikhils-MacBook-Air.local"
  type        = string
}

output "instance_public_ip" {
  value = google_compute_instance.deepseek-instance.network_interface[0].access_config[0].nat_ip
}