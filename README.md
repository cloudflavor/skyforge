# Skyforge

A registry of WASI plugins for infrastructure provisioning

## Building

All plugins are built using the wasm component of the Rust toolchain. To build the plugins, run the following command:

e.g. for the Hetzner plugin:

```sh
$ cargo install cargo-component --locked
...
$ cargo component build && cp ../../../target/wasm32-wasi/debug/hetzner.wasm ~/.config/skycrane/plugins/
...
```

This will build the plugin and copy the resulting wasm file to the
`~/.config/skycrane/plugins/` directory. The manual copy is necessary because we don't
have a registry in place at the moment. Once the registry is in place, skycrane will
download the plugin automatically.
