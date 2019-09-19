locals {
  template_count = lookup(var.cloud_init, "template",  null ) == null ? 0 : var.instance_count
  template_vars = lookup(var.cloud_init, "vars", {})
  port_count       = length(var.port) == 0 ? 0 : var.instance_count

}

data "template_file" "cloud_init" {
  count = local.template_count
  template = templatefile(var.cloud_init.template,
    merge(
      local.template_vars,
      {
        hostname       = format("%s_%d", var.name, count.index + 1),
        index          = count.index,
        all_fixed_ips = flatten(openstack_networking_port_v2.port.*.all_fixed_ips)
      }
  ))
}


resource "openstack_networking_port_v2" "port" {
  count              = local.port_count
  network_id         = var.port.network_id
  security_group_ids = var.security_group_ids
  admin_state_up     = "true"

  dynamic "allowed_address_pairs" {
    iterator = port
    for_each = flatten(list(var.port))
    content {
      ip_address  = lookup(port.value.allowed_address_pairs, "ip_address", null)
      mac_address = lookup(port.value.allowed_address_pairs, "mac_address", null)
    }
  }
}



resource "openstack_compute_instance_v2" "instance" {
  count               = var.instance_count
  name                = format("%s_%d", var.name, count.index + 1)
  image_name          = var.image
  flavor_name         = var.flavor
  user_data           = element(data.template_file.cloud_init.*.rendered, count.index)
  stop_before_destroy = var.stop_before_destroy
  security_groups     = (var.security_group_ids == null || length(var.port) == 0) ? var.security_groups : null

  metadata = var.tags

  dynamic "network" {
    for_each = var.networks
    content {
      name = lookup(network.value, "name", null)
      uuid = lookup(network.value, "uuid", null)
    }
  }

  dynamic "network" {
    iterator = port
    for_each = flatten(list(var.port))
    content {
      port = element(openstack_networking_port_v2.port.*.id, count.index)
    }
  }


  lifecycle {
    ignore_changes = []
  }

}
