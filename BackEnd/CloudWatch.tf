resource "aws_cloudwatch_metric_alarm" "apiMonitor" {
  alarm_name  = "api_calls_10_or_more"
  metric_name = "ApiCallCount"
  namespace   = "AWS/Lambda"
  evaluation_periods = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  dimensions ={
      name  = aws_lambda_function.myFunction.function_name
      value = aws_lambda_function.myFunction.arn
    }
  statistic = "Sum"
  period    = 60
  threshold = 20
  alarm_actions = [
    "${aws_sns_topic.my_topic.arn}"
  ]
}

resource "aws_sns_topic" "my_topic" {
  name = "my-topic"
}

resource "aws_sns_topic_subscription" "emailNoti" {
  topic_arn = aws_sns_topic.my_topic.arn
  endpoint  = "dzapcloudprojects@gmail.com"
  protocol  = "email"
}
