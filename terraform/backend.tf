terraform {
  backend "s3" {
    bucket       = "agri-pipeline-tfstate-b76fb85d"
    key          = "agriculture-data-pipeline/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}