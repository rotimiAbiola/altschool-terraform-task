terraform {
  backend "s3" {
    bucket = "mastertf"
    key    = "alt_backend.tfstate"
    region = "eu-central-1"
    access_key = "[INSERT_ACCESS_KEY]"
    secret_key = "[INSERT_SECRET_KEY]"
  }
}
