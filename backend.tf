terraform {
  backend "s3" {
    bucket       = "company-terraform-state"
    key          = "production/terraform.tfstate"
    region       = "us-west-2"
    encrypt      = true
    use_lockfile = true
  }
}
