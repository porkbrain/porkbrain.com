defmodule PorkbrainWeb.HomeControllerTest do
  use PorkbrainWeb.ConnCase

  # TODO: Test the order in which the posts are rendered to be DESC by insert
  # date.

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end

  test "GET / should render posts", %{conn: conn} do
    heading = "my test heading"
    description = "(example.com)"
    url = "https://example.com"

    conn = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts", %{
      "description" => description,
      "heading" => heading,
      "url" => url,
    })
    assert response(conn, :created)

    text = assert html_response(get(conn, "/"), 200)
    assert text =~ heading
    assert text =~ description
    assert text =~ url
  end

  test "GET / should render post description as markdown", %{conn: conn} do
    conn = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts", %{
      "description" => "#### This is MD",
      "heading" => "my test heading",
    })
    assert response(conn, :created)

    assert html_response(get(conn, "/"), 200) =~ "<h4>This is MD</h4>"
  end

  test "GET /tribute", %{conn: conn} do
    conn = get(conn, "/tribute")
    assert html_response(conn, 200) =~ "yuki"
  end

  test "GET / orders posts by inserted_at", %{conn: conn} do
    first_heading = "loremipsumabc1"
    second_heading = "somerandomstring2"

    conn_post_1 = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts", %{
      "description" => "some desc",
      "heading" => first_heading,
    })
    assert response(conn_post_1, :created)

    conn_post_2 = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts", %{
      "description" => "some desc",
      "heading" => second_heading,
    })
    assert response(conn_post_2, :created)

    html = html_response(get(conn, "/"), 200)

    {start_first, _} = :binary.match(html, first_heading)
    {start_second, _} = :binary.match(html, second_heading)

    # Assert that the later is lower in the document.
    assert start_first > start_second
  end
end
