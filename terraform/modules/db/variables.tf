variable zone {
  description = "GCP zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {}

variable db_disk_image {
  description = "Disk image reddit db"
  default     = "reddit-db-base"
}
