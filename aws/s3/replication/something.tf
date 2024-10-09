# resource "local_file" "self" {
#   count = var.s3_batch_scripts

#   content  = <<EOT
#     #!/usr/bin/env bash
#     export AWS_PROFILE=mt2-production
#     %{for k, v in data.terraform_remote_state.control_global.outputs.mt2_prd_s3_archive}
#     aws s3control create-job \
#       --account-id 846017140570 \
#       --description "${data.aws_s3_bucket.source[k].id} -> ${data.aws_s3_bucket.destination[k].id}" \
#       --operation '{"S3ReplicateObject":{}}' \
#       --report '{"Bucket":"${data.aws_s3_bucket.source[k].arn}","Prefix":"batch-replication-report", "Format":"Report_CSV_20180820","Enabled":true,"ReportScope":"AllTasks"}' \
#       --manifest-generator '{"S3JobManifestGenerator": {"ExpectedBucketOwner": "846017140570", "SourceBucket": "${data.aws_s3_bucket.source[k].arn}", "EnableManifestOutput": false, "Filter": {"EligibleForReplication": true, "ObjectReplicationStatuses": ["NONE","FAILED", "COMPLETED"]}}}' \
#       --priority 1 \
#       --role-arn ${module.iam_role_s3_batch_replication.arn} \
#       --no-confirmation-required \
#       --region us-east-1
#     %{endfor}
#   EOT
#   filename = "${path.module}/s3_batch_script.sh"
# }

# resource "aws_s3_bucket_versioning" "s3_archival" {
#   for_each = toset(values(data.aws_s3_bucket.source).*.bucket)
#   bucket   = each.key

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# ##
# ## Batch S3 stuff
# ##
# module "iam_role_s3_batch_replication" {
#   source = "../../../../cloud-scaffolding/modules/aws/molecules/iam/group_role_user"

#   name = "s3-batch-replication"
#   tags = {}
#   type = "role"

#   policy_attachments = []

#   policies = [
#     {
#       description = "S3 Batch replication to Control"
#       name        = "S3-Batch-Control-Replication"
#       policy      = data.aws_iam_policy_document.s3_batch.json
#     },
#   ]

#   role = {
#     assume_role_policy   = data.aws_iam_policy_document.s3_batch_assume.json
#     description          = "S3 Batch assume"
#     max_session_duration = 43200
#   }
# }

# data "aws_iam_policy_document" "s3_batch" {
#   statement {
#     actions = [
#       "s3:InitiateReplication",
#     ]
#     resources = [for i in values(data.aws_s3_bucket.source).*.arn : "${i}/*"]
#   }

#   statement {
#     actions = [
#       "s3:GetObject",
#       "s3:GetObjectVersion",
#     ]
#     resources = [for i in values(data.aws_s3_bucket.source).*.arn : "${i}/*"]
#   }

#   statement {
#     actions   = ["s3:PutObject"]
#     resources = [for i in values(data.aws_s3_bucket.source).*.arn : "${i}/*"]
#   }

#   statement {
#     actions = [
#       "s3:GetReplicationConfiguration",
#       "s3:PutInventoryConfiguration",
#     ]
#     resources = values(data.aws_s3_bucket.source).*.arn
#   }

#   statement {
#     actions   = ["s3:PutObject"]
#     resources = [for i in values(data.aws_s3_bucket.source).*.arn : "${i}/*"]
#   }
# }

# data "aws_iam_policy_document" "s3_batch_assume" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     effect  = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["batchoperations.s3.amazonaws.com"]
#     }
#   }
# }

# ##
# ## Default
# ##
# module "iam_role_s3_replication" {
#   source = "../../../../cloud-scaffolding/modules/aws/molecules/iam/group_role_user"

#   name = "s3-replication"
#   tags = {}
#   type = "role"

#   policy_attachments = []

#   policies = [
#     {
#       description = "Replication to S3 in Control"
#       name        = "S3-Control-Replication"
#       policy      = data.aws_iam_policy_document.replication.json
#     },
#   ]

#   role = {
#     assume_role_policy   = module.policy_docs.s3_assume
#     description          = "S3 assume"
#     max_session_duration = 43200
#   }
# }

# data "aws_iam_policy_document" "replication" {
#   statement {
#     actions = [
#       "s3:GetReplicationConfiguration",
#       "s3:ListBucket",
#     ]
#     resources = values(data.aws_s3_bucket.source).*.arn
#   }

#   statement {
#     actions = [
#       "s3:GetObjectVersionForReplication",
#       "s3:GetObjectVersionAcl",
#       "s3:GetObjectVersionTagging",
#     ]
#     resources = [for i in values(data.aws_s3_bucket.source).*.arn : "${i}/*"]
#   }

#   statement {
#     actions = [
#       "s3:ObjectOwnerOverrideToBucketOwner",
#       "s3:ReplicateObject",
#       "s3:ReplicateDelete",
#       "s3:ReplicateTags",
#     ]
#     resources = [for i in values(data.aws_s3_bucket.destination).*.arn : "${i}/*"]
#   }
# }

# data "aws_s3_bucket" "destination" {
#   provider = aws.control
#   for_each = data.terraform_remote_state.control_global.outputs.mt2_prd_s3_archive

#   bucket = each.key
# }

# data "aws_s3_bucket" "source" {
#   for_each = setintersection(values(data.terraform_remote_state.control_global.outputs.mt2_prd_s3_archive), ["uptake-mt2-production-managed-sftp20190822134738070500000001"])

#   bucket = each.value
# }
