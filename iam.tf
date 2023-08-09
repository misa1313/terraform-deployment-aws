resource "aws_iam_role" "webserver_role-2" {
  name = "webserver_role-2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Sid": ""
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com" 
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "webserver_instance_profile-2" {
  name = "webserver_instance_profile-2"

  role = aws_iam_role.webserver_role-2.name
}

resource "aws_iam_policy" "s3_session_manager_policy-2" {
  name = "S3SessionManagerPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::webserver-config-bucket/*"  
      },
      {
        Action = "ssm:StartSession",
        Effect = "Allow",
        Resource = "*"  
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "webserver_policy_attachment-2" {
  policy_arn = aws_iam_policy.s3_session_manager_policy-2.arn
  role       = aws_iam_role.webserver_role-2.name
}
