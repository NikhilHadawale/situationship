terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "coastal-mesh-443616-m2"
  region  = "us-central1"
  zone    = "us-central1-a"
}
