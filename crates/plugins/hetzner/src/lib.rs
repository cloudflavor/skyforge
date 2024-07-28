use skyforge_sdk::skyforge_plugin;

struct Hetzner;

#[skyforge_plugin]
impl SkyforgePlugin for Hetzner {
    fn deserialize_config_impl(config: String) -> Result<Config, Error> {
        println!("Hetzner config: {}", config);
        Ok(Config { name: config })
    }
}
