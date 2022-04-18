use crate::prelude::*;
use handlebars::Handlebars;
use serde_json::json;

const TEMPLATE_CONTENTS: &str = include_str!("templates/index.handlebars.html");

const TEMPLATE_NAME: &str = "index";

mod helpers {
    use handlebars::handlebars_helper;

    handlebars_helper!(
        md_to_html: |s: Option<String>| {
            s
                .map(|s| markdown::to_html(&s))
                .unwrap_or_default()
        }
    );
}

pub fn render(posts: &[GroupedPosts]) -> Result<String> {
    let mut handlebars = Handlebars::new();

    handlebars.register_helper("md_to_html", Box::new(helpers::md_to_html));
    handlebars.register_template_string(TEMPLATE_NAME, TEMPLATE_CONTENTS)?;

    let json = json!({
        "grouped_posts": posts,
    });
    let html = handlebars.render(TEMPLATE_NAME, &json)?;

    Ok(html)
}
