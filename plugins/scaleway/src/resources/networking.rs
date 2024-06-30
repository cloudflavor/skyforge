use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
pub struct Vpc {
    id: String,
    name: String,
    project_id: String,
    tags: Vec<String>,
    is_default: bool,
    created_at: String,
    updated_at: String,
    private_network_count: u32,
}
