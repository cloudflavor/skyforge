use wit_bindgen::generate;

generate!({
    world: "skyforge-api",
    path: "../../spec/wit"
});

use exports::plugin_api::{Config as PluginConfig, Error, Guest};

struct Hetzner;

impl Guest for Hetzner {
    fn deserialize_config(_config: String) -> Result<PluginConfig, Error> {
        Ok(PluginConfig {})
    }
}

export!(Hetzner);
