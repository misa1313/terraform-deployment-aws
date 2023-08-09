resource "aws_launch_configuration" "launch_config-2" {
  name_prefix          = "lconf_2-"
  image_id             = "ami-08333bccc35d71140"  
  instance_type        = "t2.micro"
  key_name             = "k1"
  security_groups      = [aws_security_group.security_group-2.id]
  iam_instance_profile = aws_iam_instance_profile.webserver_instance_profile-2.name
  user_data            = "${file("setup.sh")}"
}
