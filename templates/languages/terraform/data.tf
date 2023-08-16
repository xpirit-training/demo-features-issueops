# DATA
#
# Examples
#
# data "aws_ami" "example" {
#   id = var.aws_ami_id
#
#   lifecycle {
#     # The AMI ID must refer to an existing AMI that has the tag "nomad-server".
#     postcondition {
#       condition     = self.tags["Component"] == "nomad-server"
#       error_message = "tags[\"Component\"] must be \"nomad-server\"."
#     }
#   }
# }
