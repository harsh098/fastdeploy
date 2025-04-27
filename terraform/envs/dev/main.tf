resource "aws_s3_bucket" "simple_bucket" {
  bucket = "${local.environment}-github-atlantis-pr-automation-test"
}