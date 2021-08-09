resource "aws_launch_configuration" "ec2_lc" {
  associate_public_ip_address = true
  name = "ec2_lc_01"
  image_id = "${data.aws_ami.latest_amazon.id}"
  instance_type = "${var.instance_type}"
  security_groups = [aws_security_group.BHsg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  user_data = templatefile("user_data.sh", {
   eip    = "${aws_eip.BH.id}",
   region = "${var.region}"
 })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "BH" {
  vpc = true

  tags = "${var.common_tags}"
}



resource "aws_autoscaling_group" "bastion" {
  name = "ASG-${aws_launch_configuration.ec2_lc.name}"
  launch_configuration = aws_launch_configuration.ec2_lc.name
  min_size = 1
  max_size = 1
  min_elb_capacity = 1
  vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]

  tags = [ {
      key = "Name"
      value = "Bastion-Host by Sergey Brekunov"
      propagate_at_launch = true
    }]
  }

  resource "aws_default_subnet" "default_az1" {
    availability_zone = data.aws_availability_zones.available.names[0]
    }

  resource "aws_default_subnet" "default_az2" {
    availability_zone = data.aws_availability_zones.available.names[1]
    }
