resource "aws_instance" "interview" {
  ami                         = data.aws_ami.amazon_linux_2.id
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  key_name                    = var.ssh_key
  subnet_id                   = aws_subnet.interview.id
  user_data                   = file("${path.module}/user_data.tpl")
  vpc_security_group_ids      = [aws_security_group.interview.id]

  root_block_device {
    encrypted   = true
    volume_size = 25
  }

  tags = var.tags
}
