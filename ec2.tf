resource "aws_instance" "app_server" {
  ami           = "ami-090717c950a5c34d3"
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
