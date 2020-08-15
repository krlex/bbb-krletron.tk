provider "google" {
   credentials = file("tfsvc.json")
   project     = "testing-system-270517"
   region      = "us-central1"
}

resource "google_compute_instance" "default" {
  name         = "class"
  machine_type = "n1-standard-4"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
    image = "ubuntu-1604-xenial-v20200807"
  }
}

  metadata_startup_script = "sudo apt-get -y update; sudo apt-get -y dist-upgrade ;"
  provisioner "file" {
    source      = "./script.sh"
    destination = "/tmp/script.sh"
  }
  network_interface {
  network = "default"
  access_config {
    }
  }
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
