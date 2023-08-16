# LOCALS
#
# Examples
#
# locals {
#   # Ids for multiple sets of EC2 instances, merged together
#   instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
# }
#
# locals {
#   # Common tags to be assigned to all resources
#   common_tags = {
#     Service = local.service_name
#     Owner   = local.owner
#   }
# }

locals {
}
