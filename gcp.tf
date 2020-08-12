provider "google" {
  credentials = file("tfsvc.json")
  version = "3.34"
  region  = "us-central1"
  project = "testing-system-270517"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "default" {
  name = "class"
  machine_type = "n1-standard-4"

  boot_disk {
   initialize_params {
     image = "ubuntu-1604-xenial-v20200807"
   }
}

 network_interface {
   network = "default"
}
}
