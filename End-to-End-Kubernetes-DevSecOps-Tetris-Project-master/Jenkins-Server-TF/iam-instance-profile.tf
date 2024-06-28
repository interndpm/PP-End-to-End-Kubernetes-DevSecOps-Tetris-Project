resource "aws_iam_instance_profile" "instance-profile" {
  name = "Jenkins-instance-profile-pp"
  role = aws_iam_role.iam-role.name
}
