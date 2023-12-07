data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "lambda_dynamodb_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = "dynamodb:UpdateItem"
          Resource = var.dynamodb_table_arn
        }
      ]
    })
  }
}


data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/terraform/modules/lambda.py"
  output_path = "${path.module}/terraform/modules/lambda_function_payload.zip"
}

resource "aws_lambda_function" "myFunction" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "myFunctionViewer"
  role          = aws_iam_role.iam_for_lambda.arn

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.7"
  handler = "lambda.lambda_handler" #the lambda. refers to the 'lambda.py resource and the lambda_handler refers to the method in the function code that processes events.

  environment {
    variables = {
      DYNAMODB_TABLE = var.table_name
      ENVIRONMENT = var.environment
    }
  }
}