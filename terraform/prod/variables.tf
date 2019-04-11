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

variable reddit_count {
  type    = "string"
  default = "1"
}

variable db_disk_image {
  description = "Disk image reddit db"
  default     = "reddit-db-base"
}

variable app_disk_image {
  description = "Disk image reddit app"
  default     = "reddit-app-base"
}
