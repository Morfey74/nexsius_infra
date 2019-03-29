terraform {
	required_version = "0.11.13"
}

provider "google" {
	version = "2.0.0"
	project = "fluted-elixir-234916"
	region = "europe-west-1"
}

resource "google_compute_instance" "app" {
	name = "reddit-app"
	machine_type = "g1-small"
	zone = "europe-west1-b"
	
	boot_disk {
		initialize_params {
			image = "reddit-base-1553858547"
		}
	}

        metadata {
        	ssh-keys = "appuser:${file("~/.ssh/appuser.pub")}"
	}

	network_interface {
		network = "default"
		access_config {}		
	}		
}
