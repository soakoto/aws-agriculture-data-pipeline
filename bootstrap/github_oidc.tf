# The GitHub Actions OIDC provider already exists at the account level.
# Look it up rather than trying to create a duplicate provider.
data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

# resource "aws_iam_openid_connect_provider" "github" {
#   url = "https://token.actions.githubusercontent.com"
#
#   client_id_list = [
#     "sts.amazonaws.com"
#   ]
# }

resource "aws_iam_role" "github_actions" {
  name = "agriculture-data-pipeline-github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = data.aws_iam_openid_connect_provider.github.arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }

          # GitHub's immutable-ID subject includes both the owner and repository IDs.
          # The wildcard allows refs/environments under this repository only.
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:soakoto@${var.github_owner_id}/aws-agriculture-data-pipeline@${var.github_repository_id}:*"
          }
        }
      }
    ]
  })

  tags = {
    Project     = "agriculture-data-pipeline"
    Environment = "dev"
    Purpose     = "github-actions"
  }
}