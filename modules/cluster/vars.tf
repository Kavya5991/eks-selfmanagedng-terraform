variable "cluster_name"{
  type=string
  description="Enter name of cluster"
  default="awseks"
}
variable "enable_cluster_logs"{
 description = "Set to true to enable cluster logs"
  default     = true
}
/*output value from IAM module*/
variable "cluster_role_arn" {
  type    = string
}
/*output value from vpc module*/
variable "public_subnet_ids" {
  type        = list(string)
  description = "The list of public subnet IDs to launch the EKS Cluster"
}
variable "create_cloudwatch_log_group" {
  type        = bool
  description = "set it to true to create the CloudWatch log group"
  default     = true
}