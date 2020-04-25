defmodule BausanoWeb.HomeControllerTest do
  use BausanoWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end

  test "GET / should render posts", %{conn: conn} do
    heading = "my test heading"
    description = "(example.com)"
    url = "https://example.com"

    conn = post(conn, "/api/posts", %{
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
end
