variable "ssh_key_pair_name" {
  default = "un@laptop.localdomain"
}
variable "ami_id" {
  default     = "ami-0f3a43fbf2d3899f7"
  description = "Amazon Linux 2 AMI (HVM), SSD Volume Type"
}

variable "availability_zone" {
  default = "eu-central-1a"
}