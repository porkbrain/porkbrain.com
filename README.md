# Bausano

## Running in docker
We're using [this guide][docker-with-phoenix] to set up a testing environment in
which our Phoenix app talks to Docker.

Use `docker-compose up --abort-on-container-exit` to create the container. Tests
can be run in the container with `docker-compose run bausano mix test`.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## New database table
To set up new database table, refer to [this Ecto tutorial][ecto-new-table]. For
list of database fields refer to the [documentation here][ecto-types]. The
primary key column named `id` is created by default.

## Postgres
You can list all databases with `\l`. Then connect to a database with
`\c {db_name}`. To list database tables use `\dt`. `\d+ {table_name}` prints the
structure of a table.

## Markdown
Markdown [engine][md-engine] is added, therefore pages can be written in MD if
they have suffix `html.md`.

## Useful references
- [Building a JSON API with Phoenix 1.3 and Elixir][building-json-api]
- [Elixir JSON Schema validator][validate-json-schema]

<!-- Invisible List of References -->
[docker-with-phoenix]: https://github.com/fireproofsocks/phoenix-docker-compose
[ecto-new-table]: https://hexdocs.pm/phoenix/ecto.html
[ecto-types]: https://hexdocs.pm/ecto/Ecto.Type.html#types
[building-json-api]: https://dev.to/lobo_tuerto/building-a-json-api-with-phoenix-13-and-elixir-ooo
[validate-json-schema]: https://github.com/jonasschmidt/ex_json_schema
[md-engine]: https://github.com/boydm/phoenix_markdown
