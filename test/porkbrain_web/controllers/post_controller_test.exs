defmodule PorkbrainWeb.PostControllerTest do
  use PorkbrainWeb.ConnCase

  test "POST /api/posts", %{conn: conn} do
    conn = post(conn, "/api/posts", %{
      "description" => "(example.com)",
      "heading" => "Test post",
      "url" => "http://example.com",
    })
    assert response(conn, :created)
  end

  test "POST /api/posts url should be optional", %{conn: conn} do
    conn = post(conn, "/api/posts", %{
      "description" => "(example.com)",
      "heading" => "Test post",
    })
    assert response(conn, :created)
  end

  test "POST /api/posts should fail if missing args", %{conn: conn} do
    conn = post(conn, "/api/posts", %{
      "description" => "(example.com)",
      "url" => "http://example.com",
    })
    assert json_response(conn, :unprocessable_entity) == %{
      "message" => "Required property heading was not present."
    }

    conn = post(conn, "/api/posts", %{
      "heading" => "Test post",
      "url" => "http://example.com",
    })
    assert json_response(conn, :unprocessable_entity) == %{
      "message" => "Required property description was not present."
    }
  end
end
