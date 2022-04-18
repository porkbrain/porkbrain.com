mod db;
mod html;
mod prelude;

use prelude::*;
use rusqlite::Connection;
use std::fs;

fn main() -> Result<()> {
    let conn = Connection::open_in_memory()?;

    conn.execute(
        "CREATE TABLE posts (
            id              INTEGER PRIMARY KEY,
            heading         TEXT NOT NULL,
            description     TEXT,
            url             TEXT,
            inserted_at     TEXT NOT NULL,
            updated_at      TEXT NOT NULL
        )",
        [],
    )?;

    conn.execute_batch(include_str!("../backup.sql"))?;

    let posts = db::select_posts_grouped_by_yearmonth(&conn)?;
    let index = html::render(&posts)?;

    fs::write("dist/index.html", index)?;

    Ok(())
}
