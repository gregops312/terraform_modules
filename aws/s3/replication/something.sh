#!/usr/bin/env bash
export AWS_PROFILE=mt2-production

aws s3control create-job \
  --account-id 846017140570 \
  --description "uptake-datastax-mt2-production-backups -> mt2-prd-archive-datastax-cassandra" \
  --operation '{"S3ReplicateObject":{}}' \
  --report '{"Bucket":"arn:aws:s3:::uptake-datastax-mt2-production-backups","Prefix":"batch-replication-report", "Format":"Report_CSV_20180820","Enabled":true,"ReportScope":"AllTasks"}' \
  --manifest-generator '{"S3JobManifestGenerator": {"ExpectedBucketOwner": "846017140570", "SourceBucket": "arn:aws:s3:::uptake-datastax-mt2-production-backups", "EnableManifestOutput": false, "Filter": {"EligibleForReplication": true, "ObjectReplicationStatuses": ["NONE","FAILED", "COMPLETED"]}}}' \
  --priority 1 \
  --role-arn arn:aws:iam::846017140570:role/s3-batch-replication \
  --no-confirmation-required \
  --region us-east-1

aws s3control create-job \
  --account-id 846017140570 \
  --description "terraform-2019121821553589520000000c -> mt2-prd-archive-pg-datascience" \
  --operation '{"S3ReplicateObject":{}}' \
  --report '{"Bucket":"arn:aws:s3:::terraform-2019121821553589520000000c","Prefix":"batch-replication-report", "Format":"Report_CSV_20180820","Enabled":true,"ReportScope":"AllTasks"}' \
  --manifest-generator '{"S3JobManifestGenerator": {"ExpectedBucketOwner": "846017140570", "SourceBucket": "arn:aws:s3:::terraform-2019121821553589520000000c", "EnableManifestOutput": false, "Filter": {"EligibleForReplication": true, "ObjectReplicationStatuses": ["NONE","FAILED", "COMPLETED"]}}}' \
  --priority 1 \
  --role-arn arn:aws:iam::846017140570:role/s3-batch-replication \
  --no-confirmation-required \
  --region us-east-1

aws s3control create-job \
  --account-id 846017140570 \
  --description "terraform-2019020520524213680000000c -> mt2-prd-archive-pg-edge" \
  --operation '{"S3ReplicateObject":{}}' \
  --report '{"Bucket":"arn:aws:s3:::terraform-2019020520524213680000000c","Prefix":"batch-replication-report", "Format":"Report_CSV_20180820","Enabled":true,"ReportScope":"AllTasks"}' \
  --manifest-generator '{"S3JobManifestGenerator": {"ExpectedBucketOwner": "846017140570", "SourceBucket": "arn:aws:s3:::terraform-2019020520524213680000000c", "EnableManifestOutput": false, "Filter": {"EligibleForReplication": true, "ObjectReplicationStatuses": ["NONE","FAILED", "COMPLETED"]}}}' \
  --priority 1 \
  --role-arn arn:aws:iam::846017140570:role/s3-batch-replication \
  --no-confirmation-required \
  --region us-east-1

aws s3control create-job \
  --account-id 846017140570 \
  --description "terraform-20190614225026766700000018 -> mt2-prd-archive-pg-escher2" \
  --operation '{"S3ReplicateObject":{}}' \
  --report '{"Bucket":"arn:aws:s3:::terraform-20190614225026766700000018","Prefix":"batch-replication-report", "Format":"Report_CSV_20180820","Enabled":true,"ReportScope":"AllTasks"}' \
  --manifest-generator '{"S3JobManifestGenerator": {"ExpectedBucketOwner": "846017140570", "SourceBucket": "arn:aws:s3:::terraform-20190614225026766700000018", "EnableManifestOutput": false, "Filter": {"EligibleForReplication": true, "ObjectReplicationStatuses": ["NONE","FAILED", "COMPLETED"]}}}' \
  --priority 1 \
  --role-arn arn:aws:iam::846017140570:role/s3-batch-replication \
  --no-confirmation-required \
  --region us-east-1

aws s3control create-job \
  --account-id 846017140570 \
  --description "uptake-mt2-production-managed-sftp20190822134738070500000001 -> mt2-prd-archive-platform-managed-sftp-data" \
  --operation '{"S3ReplicateObject":{}}' \
  --report '{"Bucket":"arn:aws:s3:::uptake-mt2-production-managed-sftp20190822134738070500000001","Prefix":"batch-replication-report", "Format":"Report_CSV_20180820","Enabled":true,"ReportScope":"AllTasks"}' \
  --manifest-generator '{"S3JobManifestGenerator": {"ExpectedBucketOwner": "846017140570", "SourceBucket": "arn:aws:s3:::uptake-mt2-production-managed-sftp20190822134738070500000001", "EnableManifestOutput": false, "Filter": {"EligibleForReplication": true, "ObjectReplicationStatuses": ["NONE","FAILED", "COMPLETED"]}}}' \
  --priority 1 \
  --role-arn arn:aws:iam::846017140570:role/s3-batch-replication \
  --no-confirmation-required \
  --region us-east-1
