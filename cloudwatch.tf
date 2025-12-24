resource "aws_cloudwatch_dashboard" "eazylabs_cd" {
  dashboard_name = local.cloudwatch_dashboard_name # Nom du tableau de bord

  dashboard_body = jsonencode({
    "widgets" = [
      {
        "height" = 6
        "width"  = 6
        "y"      = 0
        "x"      = 0
        "type"   = "metric"
        "properties" = {
          "metrics" = [
            ["${local.cloudwatch_dashboard_name}", "session-count", "stack", "ansibleclient"],
            ["...", "ansibleserver"],
            ["...", "docker"],
            ["...", "jenkins"],
            ["...", "kubernetes"],
            ["...", "total"]
          ]
          "view"    = "timeSeries"
          "stacked" = false
          "region"  = "${local.aws_region}"
          "stat"    = "Maximum"
          "period"  = 900
          "yAxis" = {
            "left" = {
              "min"   = 0
              "label" = "stack-count"
            }
          }
        }
      }
    ]
  })
}
