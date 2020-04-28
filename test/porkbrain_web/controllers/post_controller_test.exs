defmodule PorkbrainWeb.PostControllerTest do
  use PorkbrainWeb.ConnCase

  test "POST /api/posts", %{conn: conn} do
    conn = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts", %{
      "description" => "(example.com)",
      "heading" => "Test post",
      "url" => "http://example.com",
    })
    assert response(conn, :created)
  end

  test "POST /api/posts url should be optional", %{conn: conn} do
    conn = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts", %{
      "description" => "(example.com)",
      "heading" => "Test post",
    })
    assert response(conn, :created)
  end

  test "POST /api/posts should fail if missing args", %{conn: conn} do
    conn_1 = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts", %{
      "description" => "(example.com)",
      "url" => "http://example.com",
    })
    assert json_response(conn_1, :unprocessable_entity) == %{
      "message" => "Required property heading was not present."
    }

    conn_2 = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts", %{
      "heading" => "Test post",
      "url" => "http://example.com",
    })
    assert json_response(conn_2, :unprocessable_entity) == %{
      "message" => "Required property description was not present."
    }
  end

  test "POST /api/posts fails with invalid authorization", %{conn: conn} do
    conn_1 = conn
    |> put_req_header("authorization", "Bearer wrong-token")
    |> post("/api/posts", %{
      "description" => "(example.com)",
      "heading" => "Test post",
      "url" => "http://example.com",
    })
    assert response(conn_1, :unauthorized)

    conn_2 = post(conn, "/api/posts", %{
      "description" => "(example.com)",
      "heading" => "Test post",
      "url" => "http://example.com",
    })
    assert response(conn_2, :unauthorized)
  end
end
