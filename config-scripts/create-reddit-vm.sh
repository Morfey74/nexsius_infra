#! /bin/bash

gcloud compute instances create reddit-app \
  --image-family reddit-full \
  --tags puma-server \
  --zone=europe-west1-d \
--restart-on-failure
