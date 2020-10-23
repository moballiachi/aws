variable "region" {  
  default = "us-east-1" 
}

variable "role_arn" {
  description = "ARN of IAM role to be attached to Lambda Function."
  default     = "arn:aws:iam::HEREYOURIDTENAT:role/catalogue-lambda-role"
}

variable "lambda_description" {
  description = "Description of what your Lambda Function does."
  default     = "FaaS which is used to active an event for processing data. This FaaS was made by terraform."
}

variable "lambda_name" {
  description = "Lambda function name."
  default     = "faas-CataloguesGet"
}

variable "lambda_endpoint_name" {
  description = "Entrypoint function to be call like handler."
  default     = "__init__.handler"
}

variable "lambda_memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  default     = "128"
}

variable "lambda_runtime" {
  description = "runtime"
  default     = "python3.6"
}

variable "lambda_timeout" {
  description = "The amount of time your Lambda Function has to run in seconds. Defaults to 5 minutes."
  default     = "300"
}

variable "lambda_source_code_path" {
  description = "Path to the source file or directory containing your Lambda source code."
  default     = "source_code"
}

variable "lambda_resource_code_path" {
  description = "Path where is set up all resource which are necerasy to install our source code."
  default     = "source_resource"
}

variable "lambda_output_path" {
  description = "Path to the function's deployment package within local filesystem. eg: /path/to/lambda.zip"
  default     = "source_output"
}

variable "lambda_output_zip" {
  description = "Path to the function's deployment package within local filesystem. eg: /path/to/lambda.zip"
  default     = "lambda.zip"
}

variable "environment" {
  description = "Environment configuration for the Lambda function."
  type        = "map"
  default     = {}
}