pub use skyforge_sdk_macros::skyforge_plugin;

wit_bindgen::generate!({
    path: "wit",
    world: "skyforge-api",
});
