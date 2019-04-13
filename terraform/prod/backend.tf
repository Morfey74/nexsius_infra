terraform {
  backend "gcs" {
    bucket = "storage-bucket-nexs"
    prefix = "prod"
  }
}

