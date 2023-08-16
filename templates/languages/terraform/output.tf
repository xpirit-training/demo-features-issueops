# OUTPUTS
#
# Examples
#
# output "api_base_url" {
#   value = "https://${aws_instance.example.private_dns}:8433/"

#   # The EC2 instance must have an encrypted root volume.
#   precondition {
#     condition     = data.aws_ebs_volume.example.encrypted
#     error_message = "The server's root volume is not encrypted."
#   }
# }
#
# output "db_password" {
#   value       = aws_db_instance.db.password
#   description = "The password for logging in to the database."
#   sensitive   = true
# }
