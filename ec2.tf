resource "aws_instance" "public" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.docker_on_ec2.id, ]
  #key_name               = aws_key_pair.instance_key.key_name
  availability_zone      = "${data.aws_region.current.name}a"
 
 user_data = filebase64("user-data.sh") 

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-ec2" })
  )
}