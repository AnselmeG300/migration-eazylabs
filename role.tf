resource "aws_iam_role" "eazylabs_lambda_role" {
  name = "eazylabs-lambda-role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF
}


resource "aws_iam_policy" "eazylabs_lambda_ssm_policy" {
  name        = "eazylabs-lambda-ssm-ec2-policy"
  description = "Authorization of lambda EAZYlabs on ssm"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "ssm:SendCommand",
          "autoscaling:DescribeAutoScalingNotificationTypes",
          "ssm:ListCommands",
          "autoscaling:DescribeScalingProcessTypes",
          "autoscaling:DescribePolicies",
          "ssm:DescribeMaintenanceWindowSchedule",
          "ssm:SendAutomationSignal",
          "ssm:DescribeInstancePatches",
          "autoscaling:*",
          "ssm:GetMaintenanceWindowExecutionTaskInvocation",
          "ssm:DescribeAutomationExecutions",
          "elasticloadbalancing:DescribeLoadBalancers",
          "ssm:DescribeMaintenanceWindowExecutionTaskInvocations",
          "autoscaling:DescribeAdjustmentTypes",
          "ssm:ListOpsMetadata",
          "ssm:DescribeParameters",
          "autoscaling:DescribeAutoScalingGroups",
          "ssm:ListResourceDataSync",
          "autoscaling:DescribeWarmPool",
          "ssm:ListDocuments",
          "autoscaling:DescribeNotificationConfigurations",
          "autoscaling:DescribeInstanceRefreshes",
          "ssm:DescribeMaintenanceWindowsForTarget",
          "autoscaling:GetPredictiveScalingForecast",
          "ssm:ListComplianceItems",
          "ssm:GetMaintenanceWindowExecutionTask",
          "autoscaling:DescribeTags",
          "ssm:GetMaintenanceWindowExecution",
          "ssm:ListResourceComplianceSummaries",
          "autoscaling:DescribeMetricCollectionTypes",
          "autoscaling:DescribeLoadBalancers",
          "ssm:ListOpsItemRelatedItems",
          "ssm:DescribeOpsItems",
          "elasticloadbalancing:DescribeLoadBalancerAttributes",
          "autoscaling:DescribeTrafficSources",
          "ssm:StartAutomationExecution",
          "elasticloadbalancing:DescribeTargetGroupAttributes",
          "ssm:DescribeMaintenanceWindows",
          "elasticloadbalancing:DescribeAccountLimits",
          "ec2:*",
          "elasticloadbalancing:DescribeRules",
          "ssm:ListCommandInvocations",
          "ssm:DescribePatchGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeTerminationPolicyTypes",
          "autoscaling:DescribeLaunchConfigurations",
          "ssm:PutConfigurePackageResult",
          "ssm:DescribePatchGroupState",
          "ssm:GetManifest",
          "iam:PassRole",
          "elasticloadbalancing:DescribeListeners",
          "ssm:DescribeInstancePatchStates",
          "ssm:DescribeInstancePatchStatesForPatchGroup",
          "autoscaling:DescribeScalingActivities",
          "autoscaling:DescribeAccountLimits",
          "ssm:GetInventorySchema",
          "autoscaling:DescribeScheduledActions",
          "elasticloadbalancing:DescribeListenerCertificates",
          "autoscaling:DescribeLoadBalancerTargetGroups",
          "ssm:DescribeInstanceProperties",
          "elasticloadbalancing:DescribeSSLPolicies",
          "ssm:ListInventoryEntries",
          "autoscaling:DescribeLifecycleHookTypes",
          "ssm:ListOpsItemEvents",
          "ssm:GetDeployablePatchSnapshotForInstance",
          "elasticloadbalancing:DescribeTags",
          "ssm:DescribeSessions",
          "ssm:DescribePatchBaselines",
          "ssm:DescribeInventoryDeletions",
          "ssm:DescribePatchProperties",
          "ssm:GetInventory",
          "ssm:DescribeActivations",
          "ssm:StopAutomationExecution",
          "ssm:GetCommandInvocation",
          "autoscaling:DescribeLifecycleHooks",
          "ssm:ListComplianceSummaries",
          "iam:CreateServiceLinkedRole",
          "ssm:DescribeInstanceInformation",
          "ssm:*",
          "elasticloadbalancing:DescribeTargetHealth",
          "elasticloadbalancing:DescribeTargetGroups",
          "ssm:ListAssociations",
          "ssm:DescribeAvailablePatches"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetAutomationExecution",
          "ssm:ListDocumentVersions",
          "ssm:GetDefaultPatchBaseline",
          "ssm:DescribeDocument",
          "ssm:ListDocumentMetadataHistory",
          "ssm:DescribeMaintenanceWindowTasks",
          "ssm:ListAssociationVersions",
          "ssm:GetPatchBaselineForPatchGroup",
          "ssm:ListInstanceAssociations",
          "ssm:GetParameter",
          "ssm:DescribeMaintenanceWindowExecutions",
          "ssm:GetMaintenanceWindowTask",
          "ssm:DescribeMaintenanceWindowExecutionTasks",
          "ssm:DescribeAutomationStepExecutions",
          "ssm:GetDocument",
          "ssm:GetParametersByPath",
          "ssm:GetMaintenanceWindow",
          "ssm:DescribeInstanceAssociationsStatus",
          "ssm:DescribeAssociationExecutionTargets",
          "ssm:GetPatchBaseline",
          "ssm:DescribeAssociation",
          "ssm:GetConnectionStatus",
          "ssm:GetOpsItem",
          "ssm:GetParameterHistory",
          "ssm:DescribeMaintenanceWindowTargets",
          "ssm:DescribeEffectiveInstanceAssociations",
          "ssm:GetParameters",
          "ssm:GetResourcePolicies",
          "ssm:GetOpsSummary",
          "ssm:GetOpsMetadata",
          "ssm:StartAutomationExecution",
          "ssm:ListTagsForResource",
          "ssm:DescribeDocumentParameters",
          "ssm:DescribeEffectivePatchesForPatchBaseline",
          "ssm:GetServiceSetting",
          "ssm:DescribeAssociationExecutions",
          "ssm:GetCalendar",
          "ssm:DescribeDocumentPermission",
          "ssm:GetCalendarState"
        ],
        "Resource" : [
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:document/*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:opsmetadata/*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:patchbaseline/*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:association/*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:automation-definition/*:*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:servicesetting/*",
          "arn:aws:ec2:${local.aws_region}:${data.aws_caller_identity.current.account_id}:instance/${local.instance_name}",
          "arn:aws:ecs:*:${data.aws_caller_identity.current.account_id}:task/*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:maintenancewindow/*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter/*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:automation-execution/*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:managed-instance/*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:opsitemgroup/default",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:resource-data-sync/*",
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:opsitem/*"
        ]
      }
    ]
  })
}


resource "aws_iam_policy" "eazylabs_lambda_logging_policy" {
  name        = "eazylabs-lambda-logging-policy"
  description = "IAM policy for logging from a Lambda function"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "logs:CreateLogGroup",
        "Resource" : "arn:aws:logs:${local.aws_region}:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : [
          "arn:aws:logs:${local.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.function_name}:*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudwatch:PutMetricData"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "cloudwatch:namespace" : "${local.cloudwatch_dashboard_name}"
          }
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "eazylabs_lambda_smm_attachment" {
  role       = aws_iam_role.eazylabs_lambda_role.name
  policy_arn = aws_iam_policy.eazylabs_lambda_ssm_policy.arn
}

resource "aws_iam_role_policy_attachment" "eazylabs_lambda_logging_attachment" {
  role       = aws_iam_role.eazylabs_lambda_role.name
  policy_arn = aws_iam_policy.eazylabs_lambda_logging_policy.arn
}

resource "aws_iam_role" "eazylabs_ec2_role" {
  name = "eazylabs-ec2-role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
  }
  EOF
}


resource "aws_iam_role_policy_attachment" "eazylabs_ec2_cloudwatch_full2_attachment" {
  role       = aws_iam_role.eazylabs_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccessV2"
}


resource "aws_iam_role_policy_attachment" "eazylabs_ec2_cloudwatch_full_attachment" {
  role       = aws_iam_role.eazylabs_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}


resource "aws_iam_role_policy_attachment" "eazylabs_ec2_cloudwatch2_attachment" {
  role       = aws_iam_role.eazylabs_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}


resource "aws_iam_role_policy_attachment" "eazylabs_ec2_S3_attachment" {
  role       = aws_iam_role.eazylabs_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


resource "aws_iam_role_policy_attachment" "eazylabs_ec2_SSM_attachment" {
  role       = aws_iam_role.eazylabs_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}