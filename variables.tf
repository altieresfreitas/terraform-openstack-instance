variable "instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "instance_name"
}

variable "image" {
  description = "Image that will be used to create instance"
}

variable "flavor" {
  description = "The Instance Flavor"
}

variable "networks" {
  description = "The network list used to attach the instance"
  default     = []
  type        = list
}

variable "port" {
  description = "The config to define create_port"
  default     = []
}

variable "cloud_init" {
  description = "cloud_init is a map containing template and variables to render"
  default     = {}
}

variable "tags" {
  description = "tags map to use on instance metadata"
  default     = {}
}

variable "security_group_ids" {
  description = "security_group_ids list to associate with instance"
  default     = null
}

variable "security_groups" {
  description = "security_groups list to associate with instance"
  default     = null
}

variable "stop_before_destroy" {
  description = "Boolean to define if instance needs stop before destroy"
  default     = false
}


