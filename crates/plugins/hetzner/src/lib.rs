use skyforge_sdk::skyforge_plugin;

struct Hetzner;
use exports::cloudflavor::skyforge::plugin_api::Error as ApiError;

#[skyforge_plugin]
impl SkyforgePlugin for Hetzner {
    fn get_version_impl() -> String {
        "0.1.0".to_string()
    }

    fn verify_config_impl(config: Config) -> Result<(), ApiError> {
        println!("Config: {:?}", config);
        Ok(())
    }
}
