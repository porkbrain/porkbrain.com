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
end
