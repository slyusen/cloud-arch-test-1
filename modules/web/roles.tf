# ECS task execution role data
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid = "1"
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }   
  }
}

data "aws_iam_policy_document" "ecr_s3_policy_doc" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "ecr:*"
    ]
    
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "ecr_s3_policy" {
  name   = "ecr-s3-policy"
  policy = "${data.aws_iam_policy_document.ecr_s3_policy_doc.json}"
}


# ECS task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

resource "aws_iam_role_policy_attachment" "ecr_s3_bucket_policy_attach" {
  role       = "${aws_iam_role.ecs_task_execution_role.name}"
  policy_arn = "${aws_iam_policy.ecr_s3_policy.arn}"
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}