resource "tls_private_key" "rsa" {
  algorithm = var.rsa_key_algorithm
  rsa_bits  = var.rsa_key_bits
}
resource "aws_key_pair" "tf-key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}
//store private key in local system
resource "local_file" "tf-key" {
    content = tls_private_key.rsa.private_key_pem
    filename = "tfjenkinskey"
}

resource "aws_launch_template" "launch_template" {
  name          = var.launch_template_name
  image_id      = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    security_groups = var.asg_security_group_id
  }
   iam_instance_profile {
    arn = var.eks_self_managed_node_group_instance_profile_arn
  }
  tag_specifications {
    resource_type = var.resource_type

    tags = {
    Name = var.launch_template_ec2_name
    }
  }

 }

resource "aws_autoscaling_group" "auto_scaling_group" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.public_subnet_ids

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}
