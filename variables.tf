variable "name" {
  type = string
}

variable "zone_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "type" {
  type = string
}

variable "ttl" {
  default = 300
  nullable = false
}

variable "records" {
  type = list(any)
}

variable "target_resource_id" {
  default = null
}