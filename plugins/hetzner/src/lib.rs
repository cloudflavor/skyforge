use wit_bindgen::generate;

pub mod resources;

generate!({
    world: "skyforge-api",
    path: "../../spec/wit",
});

use exports::cloudflavor::skyforge::plugin_api::{Config as PluginConfig, Error, Guest};

struct Hetzner;

impl Guest for Hetzner {
    fn deserialize_config(config: String) -> Result<PluginConfig, Error> {
        return Ok(PluginConfig { name: config });
    }
}

export!(Hetzner);
