provider "google" {
   credentials = file("tfsvc.json")
   project     = "testing-system-270517"
   region      = "us-central1"
}

resource "google_compute_instance" "class" {
  name         = "class"
  machine_type = "n1-standard-4"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
    image = "ubuntu-1604-xenial-v20200807"
  }
}

  #metadata_startup_script = "sudo apt-get -y update; sudo apt-get -y dist-upgrade ; sudo apt install nginx; sudo service nginx start"
  #provisioner "file" {
  #  source      = "./script.sh"
  #  destination = "/tmp/script.sh"
  #}
  network_interface {
  network = "default"
  access_config {
    }
  }
}

resource "google_dns_record_set" "a" {
  name         = "class.${google_dns_managed_zone.class.dns_name}"
  managed_zone = google_dns_managed_zone.class.name
  type         = "A"
  ttl          = 300

  rrdatas = [google_compute_instance.class.network_interface.0.access_config.0.nat_ip]
}

resource "google_dns_managed_zone" "class" {
  name     = "class"
  dns_name = "krletron.tk."
}

resource "google_compute_firewall" "class" {
  name    = "class-firewall"
  network = google_compute_network.class.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }
}

resource "google_compute_network" "class" {
  name = "class-network"
}


output "ip" {
  value = "${google_compute_instance.class.network_interface.0.access_config.0.nat_ip}"
}
