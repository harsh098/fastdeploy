resource "aws_iam_role" "atlantis_role" {
  name = "atlantis-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_logging" {
  role       = aws_iam_role.atlantis_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}