[![Maintained by altdump.io]]
# Instance Openstack Module

This repo contains a set of tfs for deploying openstack instances

## How to use this Module
Module definition:
```go

module "instance" {
  source  = "4ltieres/instance/openstack"
  version = "0.1.0"
  // Number of instances to be created, default = 1
  instances_count = 1
  // name is a prefix to be used when instance will be created
  name = "instance_name"
  // security_groups names list to be used on instance
  security_groups = ["default"]
  // security_group_ids list to be used on port when defined
  security_group_ids = ["security_group_id"]
  // a list of networks to be used on instance create, it will iterate over list and attach multiple networks
  networks = [{
        uuid = "network_uid"
        name = "network_name"
  }]
  // port definition to create port separated from instance
  port = {

            network_id = "network_id"
            allowed_address_pairs = {
                ip_address = "192.168.0.1/32"
                mac_address = "00:00:00:00:00:00"
            }
    }
  // image to create instance
  image = "centos7"
  // define flavor to be used on instance create
  flavor = "small.2GB"
  cloud_init = {
        template = "template_path"
        vars = "template_variables"
    }

}

```

This repo has the following folder structure:


 ```
 .

├── main.tf
├── README.md
├── variables.tf
└── versions.tf
```
