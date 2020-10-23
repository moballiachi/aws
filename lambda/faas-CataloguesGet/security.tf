resource "aws_iam_role" "role" {
  name               = "catalogue-lambda-role"
  assume_role_policy = "${file("${var.lambda_resource_code_path}/lambda-policy.json")}"
}
