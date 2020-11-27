# porkbrain.com

Personal website.

## CI/CD
The deployment is still WIP.

Prepare builder image.

```bash
docker build --tag porkbrain-builder .
```

Start builder container. Notice the second mounted volume for ssh keys.

```bash
docker run --rm -it \
    -v "${PWD}":/porkbrain \
    -v /tmp/porkbrain:/ssh_keys \
    -w "/porkbrain" \
    --name "porkbrain-builder" \
    porkbrain-builder bash
```

Run the deploy script. You need a pem file in the mounted volume to access the instance (configure .env file or pass `--pem` and `--instance` to the following script).

```bash
./prod.sh
```

To run migrations.

```bash
docker exec bin/porkbrain rpc "Elixir.Porkbrain.ReleaseTasks.migrate"
```

## Running in docker
We're using [this guide][docker-with-phoenix] to set up a testing environment in which our Phoenix app talks to Docker.

Use `docker-compose up --abort-on-container-exit` to create the container. Tests can be run in the container with `docker-compose run porkbrain mix test`.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## New database table
To set up new database table, refer to [this Ecto tutorial][ecto-new-table]. For list of database fields refer to the [documentation here][ecto-types]. The primary key column named `id` is created by default.

## Postgres
You can list all databases with `\l`. Then connect to a database with `\c {db_name}`. To list database tables use `\dt`. `\d+ {table_name}` prints the structure of a table.

To take a backup into an SQL file, use
`pg_dump -U porkbrain -W --column-inserts porkbrain > porkbrain_dump.sql`.

Transfer the file from ec2 (TODO: automatic backup uploads to S3)
`rsync -e "ssh -i prkbrn.pem" ec2-user@ec2-1-2-3-4.eu-west-1.compute.amazonaws.com:/home/ec2-user/porkbrain-backup-YYYY-MM-DD.sql .`

## Markdown
Markdown [engine][md-engine] is added, therefore pages can be written in MD if they have suffix `html.md`.

## Error page
In the cloudfront we set up a new origin to an S3 bucket and then change the default behavior to point to the [error.html](error.html) file. This way we avoid scrapers and bots hitting the server seeking for WP vulnerabilities and alike.

## Useful references
- [Building a JSON API with Phoenix 1.3 and Elixir][building-json-api]
- [Elixir JSON Schema validator][validate-json-schema]
- HTTPS [guide][plug-ssl] and [discussion][ssl-discussion]
- [MathJax basic tutorial and quick reference][mathjax-reference]

<!-- Invisible List of References -->
[docker-with-phoenix]: https://github.com/fireproofsocks/phoenix-docker-compose
[ecto-new-table]: https://hexdocs.pm/phoenix/ecto.html
[ecto-types]: https://hexdocs.pm/ecto/Ecto.Type.html#types
[building-json-api]: https://dev.to/lobo_tuerto/building-a-json-api-with-phoenix-13-and-elixir-ooo
[validate-json-schema]: https://github.com/jonasschmidt/ex_json_schema
[md-engine]: https://github.com/boydm/phoenix_markdown
[plug-ssl]: https://github.com/elixir-plug/plug/pull/803/files
[ssl-discussion]: https://elixirforum.com/t/https-ssl-phoenix-1-4/18868/6
[mathjax-reference]: https://math.meta.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference
