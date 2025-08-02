"""
Hetzner infrastructure as Code

This plugin provides a way to interact with Hetzner Cloud API and manage
resources in a declarative way using starlark.

The plugin provides the following capabilities:
- Inherit process args from the host
- Inherit process stdio from the host
- Inherit process stdout from the host
- Inherit process environment from the host
- Mount files inside wasi
- Mount directory inside wasi
"""

module(
    name = "hetzner",
    version = "v0.1.0",
    # capabilities represents a set of capabilities that the plugin gains all
    # capabilities in starlark map to the capabilities of WASI and are described here
    # https://docs.rs/wasmtime-wasi/latest/wasmtime_wasi/struct.WasiCtxBuilder.html#
    capabilities = capabilities(
        inherits = [
            # inherit process args from the host
            INHERIT_ARGS,
            # inherit process stdio from the host
            INHERIT_STDIO,
            # inherit process stdout from the host
            INHERIT_STDOUT,
            # inherit process environment from the host
            INHERIT_ENV,
        ],
        # mounts is a list of mounts that the plugin can use
        # this gives the WASI module access to the host filesystem
        mounts = [
            # mount a dir inside WASI with full capabilities, read, write files,
            # mutate directory.
            mount(
                host_path = "/var/run/",
                guest_path = "/var/run/",
                dir_perms = {
                    "read": true,
                    "mutate": true,
                },
                file_perms = {
                    "read": true,
                    "write": true,
                },
            ),
            # mount a dir inside WASI with read only capabilities
            mount(
                host_path = "/var/lib/hetzner",
                guest_path = "/mnt/hetzner",
                dir_perms = {
                    "read": true,
                    "mutate": false,
                },
                file_perms = {
                    "read": true,
                    "write": false,
                },
            ),
        ],
    ),
)
