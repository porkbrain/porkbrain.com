use serde::Serialize;

pub type Result<T> = std::result::Result<T, Box<dyn std::error::Error>>;

#[derive(Serialize)]
pub struct GroupedPosts {
    pub date: String,
    pub posts: Vec<SelectablePost>,
}

#[derive(Serialize)]
pub struct SelectablePost {
    pub heading: String,
    pub description: Option<String>,
    pub url: Option<String>,
    pub inserted_at: String,
}
