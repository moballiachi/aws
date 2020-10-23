provider "aws" {
  region = "${var.region}"
}

resource "null_resource" "install_python_dependencies" {
  triggers {
    requirements = "${sha1(file("${var.lambda_resource_code_path}/python_requirements.txt"))}"
  }

  provisioner "local-exec" {
    command = "bash ${var.lambda_resource_code_path}/lambda_pkg.sh"

    environment {
      lambda_resource_code_path = "${var.lambda_resource_code_path}"
      lambda_source_code_path   = "${var.lambda_source_code_path}"
      lambda_output_path        = "${var.lambda_output_path}"
      path_cwd                  = "${path.cwd}"
      path_module               = "${path.module}"
      lambda_name               = "${var.lambda_name}"
      python_runtime            = "${var.lambda_runtime}"
    }
  }
}

data "archive_file" "lambda_zip" {
  depends_on  = ["null_resource.install_python_dependencies"]
  type        = "zip"
  source_dir  = "${path.cwd}/${var.lambda_output_path}"
  output_path = "${path.cwd}/${var.lambda_output_zip}"
}

resource "aws_lambda_function" "lambda" {
  filename         = "${path.cwd}/${var.lambda_output_zip}"
  description      = "${var.lambda_description}"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  role             = "${var.role_arn}"
  #role             = "${aws_iam_role.role.arn}"
  function_name    = "${var.lambda_name}"
  handler          = "${var.lambda_endpoint_name}"
  runtime          = "${var.lambda_runtime}"
  timeout          = "${var.lambda_timeout}"
  memory_size      = "${var.lambda_memory_size}"

  environment = ["${slice( list(var.environment), 0, length(var.environment) == 0 ? 0 : 1 )}"]
}