# resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
#   for_each = module.prd_mt2_archive.ids

#   bucket = each.value
#   policy = data.aws_iam_policy_document.allow_access_from_another_account[each.key].json
# }

# data "aws_iam_policy_document" "allow_access_from_another_account" {
#   for_each = module.prd_mt2_archive.arn
#   statement {
#     principals {
#       type        = "AWS"
#       identifiers = ["846017140570"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket",
#       "s3:ObjectOwnerOverrideToBucketOwner",
#       "s3:ReplicateObject",
#       "s3:ReplicateDelete",
#       "s3:ReplicateTags",
#     ]

#     resources = [
#       each.value,
#       "${each.value}/*"
#     ]
#   }
# }
