resource "aws_instance" "app_server" {
  ami           = "ami-0747bdcabd34c712a"
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
