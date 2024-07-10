load("base/compute.star", "my_server_1")

my_server_1.extend(
)

module(
    name = "hetzner",
    version = "0.1.0",
    store = store(
        store_type = BackupProvider.s3,
        credentials = backup_s3_credentials,
    ),
)

backup_s3_credentials = Secret(
    name = "s3 backup credentials",
    secret_type = KeyValue,
    secrets_provider = SecretsProvider.Infisical,
)

# {
#   "apply_to": [
#     {
#       "server": {
#         "id": 42
#       },
#       "type": "server"
#     }
#   ],
#   "labels": {
#     "env": "dev"
#   },
#   "name": "Corporate Intranet Protection",
#   "rules": [
#     {
#       "description": "Allow port 80",
#       "direction": "in",
#       "port": "80",
#       "protocol": "tcp",
#       "source_ips": [
#         "28.239.13.1/32",
#         "28.239.14.0/24",
#         "ff21:1eac:9a3b:ee58:5ca:990c:8bc9:c03b/128"
#       ]
#     }
#   ]
# }

firewall_1 = Firewall(
    name = "corporate intranet protection",
    apply_to = [
        server1,
    ],
    rules = [
        FirewallRule(
            description = """
            Allow port 80
            """,
            direction = "in",
            port = 80,
            protocol = "TCP",
            source_ips = [
                "28.239.13.1/32",
                "28.239.14.0/24",
                "ff21:1eac:9a3b:ee58:5ca:990c:8bc9:c03b/128",
            ],
        ),
    ],
)

# {
#   "expose_routes_to_vswitch": false,
#   "ip_range": "10.0.0.0/16",
#   "labels": {
#     "environment": "prod",
#     "example.com/my": "label",
#     "just-a-key": ""
#   },
#   "name": "mynet",
#   "routes": [
#     {
#       "destination": "10.100.1.0/24",
#       "gateway": "10.0.1.1"
#     }
#   ],
#   "subnets": [
#     {
#       "ip_range": "10.0.1.0/24",
#       "network_zone": "eu-central",
#       "type": "cloud",
#       "vswitch_id": 1000
#     }
#   ]
# }

routes = [
    Route(
        name = "route-to-network-1",
        destination = "10.100.1.0/24",
        gateway = "10.0.1.1",
    ),
]
subnets = [
    Subnet(
        name = "subnet1",
        ip_range = "10.0.1.0/24",
        network_zone = "eu-central",
        subnet_type = "cloud",
        vswitch_id = 1000,
    ),
]

Network(
    name = "network-1",
    routes = routes,
    subnets = subnets,
    expose_routes_to_vswitch = true,
    ip_range = "10.0.0.0/16",
    labels = [
        "test",
        "stg",
    ],
)

# {
#   "automount": false,
#   "datacenter": "nbg1-dc3",
#   "firewalls": [
#     {
#       "firewall": 38
#     }
#   ],
#   "image": "ubuntu-20.04",
#   "labels": {
#     "environment": "prod",
#     "example.com/my": "label",
#     "just-a-key": ""
#   },
#   "location": "nbg1",
#   "name": "my-server",
#   "networks": [
#     456
#   ],
#   "placement_group": 1,
#   "public_net": {
#     "enable_ipv4": false,
#     "enable_ipv6": false,
#     "ipv4": null,
#     "ipv6": null
#   },
#   "server_type": "cx11",
#   "ssh_keys": [
#     "my-ssh-key"
#   ],
#   "start_after_create": true,
#   "user_data": "#cloud-config\nruncmd:\n- [touch, /root/cloud-init-worked]\n",
#   "volumes": [
#     123
#   ]
# }

ssh_key = SSHKey(
    name = "my key for stg",
    generate = False,
)

my_firewall = Firewall(
    name = "my firewall",
    apply_to = [
        server1,
    ],
    rules = [
        FirewallRule(
            description = """
            Allow port 80
            """,
            direction = "in",
            port = 80,
            protocol = "TCP",
            source_ips = [
                "28.239.13.1/32",
                "28.239.14.0/24",
                "ff21:1eac:9a3b:ee58:5ca:990c:8bc9:c03b/128",
            ],
        ),
    ],
)

my_network = Network(
    name = "network-1",
    routes = routes,
    subnets = subnets,
    expose_routes_to_vswitch = true,
    ip_range = "10.0.0.0/16",
    labels = [
        "test",
        "stg",
    ],
)

Server(
    name = "my-server",
    datacenter = "ngb1-dc3",
    image = "ubuntu-20.04",
    location = "ngb1",
    networks = [my_network],
    firewalls = [my_firewall],
)

# existing resources

existing_network = ExistingNetwork(
    name = "existing-network-1",
    filter = {
        "name": "prod-network",
        "ip_range": "172.16.0.0/16",
    },
)

ubuntu_image = ImageData(
    name = "ubuntu-latest",
    filter = {
        "distribution": "ubuntu",
        "version": "latest",
    },
)

existing_ssh_key = ExistingSSHKey(
    name = "existing-ssh-key",
    filter = {
        "fingerprint": "00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff",
    },
)

Server(
    name = "new-server",
    datacenter = "ngb1-dc3",
    image = ubuntu_image,
    location = "ngb1",
    networks = [existing_network],
    ssh_keys = [existing_ssh_key],
)
