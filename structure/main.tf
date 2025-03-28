resource "aws_s3_bucket" "terraform_state" {
    bucket = "elvintao_terraform_state"
    acl = "private"
    force_destroy = true
    versioning {
        enabled = false
    }
}