resource "aws_s3_bucket_ownership_controls" "self" {
  bucket = aws_s3_bucket.self.bucket
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_policy" "self" {
  count = var.policy == null ? 0 : 1

  bucket = aws_s3_bucket.self.id
  policy = var.policy
}

resource "aws_s3_bucket_public_access_block" "self" {
  bucket = aws_s3_bucket.self.bucket

  block_public_acls       = var.public_access_block["block_public_acls"]
  block_public_policy     = var.public_access_block["block_public_policy"]
  ignore_public_acls      = var.public_access_block["ignore_public_acls"]
  restrict_public_buckets = var.public_access_block["restrict_public_buckets"]
}

resource "aws_s3_bucket_lifecycle_configuration" "self" {
  bucket                = aws_s3_bucket.self.bucket
  expected_bucket_owner = module.data.account_id

  dynamic "rule" {
    for_each = { for i in local.lifecycle_rules : i.id => i }
    iterator = i
    content {
      id     = i.key
      status = i.value["status"]

      # expiration
      dynamic "expiration" {
        for_each = i.value["expiration"] == null ? {} : i.value["expiration"]
        content {
          days = i.value["expiration"]["days"]
        }
      }

      # transition
      dynamic "transition" {
        for_each = i.value["transition"] == null ? {} : i.value["transition"]
        content {
          days          = i.value["transition"]["days"]
          storage_class = i.value["transition"]["storage_class"]
        }
      }
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "self" {
  bucket                = aws_s3_bucket.self.bucket
  expected_bucket_owner = module.data.account_id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.server_side_encryption["kms_master_key_id"]
      sse_algorithm     = var.server_side_encryption["sse_algorithm"]
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_versioning" "self" {
  bucket                = aws_s3_bucket.self.bucket
  expected_bucket_owner = module.data.account_id

  versioning_configuration {
    status = var.versioning
  }
}
resource "aws_s3_bucket" "self" {
  bucket        = var.name
  force_destroy = false
  tags          = var.tags
}


##
## 
##
module "data" {
  source = "../metadata"
}
