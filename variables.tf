variable "instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "name" {
  description = "Name to be used on all resources as prefix"
  default = "instance_name"
}

variable "image" {
  description = "Image that will be used to create instance"
}

variable "flavor" {
  description = "The Instance Flavor"
}

variable "network" {
  description = "The network used to attach the instance"
}

variable "port" {
  description = "The config to define create_port"
  default = []
}

variable "user_data_template" {
  description = "user_data_template file used in instance"
  default = ""
}

variable "user_data_variables" {
  description = "user_data_variables used to render template_file "
  default = {}
}

variable "metadata" {
  description = "metadata map to use on instance create"
  default = {}
}

variable "security_groups" {
  description = "security_groups list to associate with instance"
  default = ["default"]
}

variable "stop_before_destroy" {
  description = "Boolean to define if instance needs stop before destroy"
  default = false
}


