terraform {
  backend "s3" {
    bucket = "terraform-roboto-backend"
    key    = "eks/roboto"
    region = "ap-northeast-2"
  }
}
