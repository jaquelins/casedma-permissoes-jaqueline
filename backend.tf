terraform {
  backend "s3" {
    bucket  = "github-oidc-terraform-aws-tfstates-orquestracao"
    encrypt = true
    key     = "permissoes_jaqueline.tfstate"
    region  = "us-east-1"
  }
}