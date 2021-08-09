resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile_01"
  role = "${aws_iam_role.ec2_eip_allow_role.name}"
}

resource "aws_iam_role" "ec2_eip_allow_role" {
  name = "ec2_role_01"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "ec2_policy" {
  name   = "ec2_policy_01"
  role   = "${aws_iam_role.ec2_eip_allow_role.id}"
  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:AssociateAddress"
              ],
              "Resource": "*"
          }
      ]
}
EOF
}
