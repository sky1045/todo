variable "name" {
  description = "general name for cluster related resources."
  default     = "roboto"
}

variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-01bfd23a56adfd0b6"
}

variable "private_subnets" {
  description = "private subnet IDs for cluster related resources."
  default     = ["subnet-0c1a17708b29d1119", "subnet-0cee6aab41b8befac"]
}

variable "public_subnets" {
  description = "public subnet IDs for cluster related resources."
  default     = ["subnet-035eb22652ba70c71", "subnet-063a9505ec522048c"]
}
