resource "aws_s3_bucket" "bucket_terraform_state" {
    bucket = "${var.project_name}_terraform_state"
    acl = "private"
    force_destroy = true
    versioning {
        enabled = false
    }
}