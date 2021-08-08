resource "aws_instance" "app_server" {
  ami           = "ami-0327006c87b23e535"
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
