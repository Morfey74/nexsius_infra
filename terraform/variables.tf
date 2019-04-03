variable project {
  description = "Project ID"
}

variable zone {
  description = "GCP zone"
  default     = "europe-west1-b"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to private key"
}

variable appuser1_pub_key {
  description = "Path to appuser1 pub key"
}


