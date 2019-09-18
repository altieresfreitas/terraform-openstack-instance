locals {
  cloud_init_count = var.user_data_template == "" ? 0 : var.instance_count
  port_count = var.port == {} ? 0 : var.instance_count

}

data "template_file" "cloud_init" {
  count    = local.cloud_init_count
  template = templatefile( var.user_data_template, merge(var.user_data_variables, { hostname = format("%s_%s", var.name, count.index + 1 ) }))
}


resource "openstack_networking_port_v2" "port" {
  count          = local.port_count
  network_id     = var.port.network_id
  admin_state_up = "true"

  dynamic "allowed_address_pairs" {

    for_each = var.port.allowed_address_pairs
    content {
      ip_address = format("%s", allowed_address_pairs.value)
    }
  }
}



resource "openstack_compute_instance_v2" "instance" {
  count               = var.instance_count
  name                = format("%s_%d", var.name, count.index + 1 )
  image_name          = var.image
  flavor_name         = var.flavor
  user_data           = element(data.template_file.cloud_init.*.rendered,count.index)
  stop_before_destroy = var.stop_before_destroy
  security_groups     = var.security_groups

  metadata = var.metadata

  dynamic "network"{
    for_each = var.network
    content {
     name = network.value
    }
  }

  lifecycle {
    ignore_changes = []
  }

}
