use crate::prelude::*;
use chrono::prelude::*;
use rusqlite::Connection;

pub fn select_posts_grouped_by_yearmonth(
    conn: &Connection,
) -> Result<Vec<GroupedPosts>> {
    let mut stmt = conn.prepare(
        "
            SELECT
                heading, description, url, inserted_at
            FROM
                posts
            ORDER BY inserted_at DESC
        ",
    )?;
    let post_iter = stmt.query_map([], |row| {
        Ok(SelectablePost {
            heading: row.get(0)?,
            description: row.get(1)?,
            url: row.get(2)?,
            inserted_at: row.get(3)?,
        })
    })?;

    let mut posts: Vec<GroupedPosts> = vec![];

    // We group posts by month, and the posts are ordered.
    // Therefore we keep track of the previous date
    // and if it fits into a new month,
    // then we "break" the post into a new vector.
    let mut prev_date: Option<String> = None;
    for post in post_iter {
        let post = post?;

        // e.g. "Feb 2021"
        let d = Utc
            .datetime_from_str(&post.inserted_at, "%Y-%m-%d %H:%M:%S")?
            .format("%b %Y")
            .to_string();

        if matches!(prev_date, Some(ref v) if v == &d) {
            // we start with None so it's safe
            debug_assert!(posts.len() > 0);
            let posts_last_index = posts.len() - 1;

            let grouped_posts = &mut posts[posts_last_index];
            grouped_posts.posts.push(post);
        } else {
            prev_date = Some(d.clone());
            posts.push(GroupedPosts {
                date: d,
                posts: vec![post],
            });
        };
    }

    Ok(posts)
}
