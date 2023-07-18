resource "aws_cloudwatch_metric_alarm" "apiMonitor" {
  alarm_name  = "api_calls_10_or_more"
  metric_name = "Count"
  namespace   = "AWS/ApiGateway"
  evaluation_periods = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  dimensions ={
      name  = aws_api_gateway_rest_api.counter.name   //This points to the name of the API
      stage_name = aws_api_gateway_stage.stage.stage_name //This points to the name of the stage the api is being tracked from
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
//The idea for this cloudwatch metric is to alert me of unusual amount of api calls in a short amount of time