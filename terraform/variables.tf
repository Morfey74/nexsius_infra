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
  type = "string"
  default = "1"
}
