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

  test "POST /api/posts/unstructured", %{conn: conn} do
    conn_post = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts/unstructured", %{
      "body" => "This is some body",
      "subject" => "Test post"
    })
    assert response(conn_post, :created)

    html = html_response(get(conn, "/"), 200)
    assert html =~ "Test post"
    assert html =~ "This is some body"
  end

  test "POST /api/posts/unstructured fails with invalid authorization", %{conn: conn} do
    conn_1 = conn
    |> put_req_header("authorization", "Bearer wrong-token")
    |> post("/api/posts/unstructured", %{
      "body" => "(example.com)",
      "subject" => "Test post"
    })
    assert response(conn_1, :unauthorized)

    conn_2 = post(conn, "/api/posts/unstructured", %{
      "body" => "(example.com)",
      "subject" => "Test post"
    })
    assert response(conn_2, :unauthorized)
  end

  test "POST /api/posts/unstructured can have empty subject", %{conn: conn} do
    conn_post = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts/unstructured", %{
      "body" => "This is some body"
    })
    assert response(conn_post, :created)

    assert html_response(get(conn, "/"), 200) =~ "This is some body"
  end

  test "POST /api/posts/unstructured can have empty description", %{conn: conn} do
    conn_post = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts/unstructured", %{
      "subject" => "Testing heading"
    })
    assert response(conn_post, :created)

    assert html_response(get(conn, "/"), 200) =~ "Testing heading"
  end

  test "POST /api/posts/unstructured cannot be completely empty", %{conn: conn} do
    conn_post = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts/unstructured", %{
      "subject" => "\n\n\n   \n\n\n",
      "body" => "\n\n\n      \n\n\n",
    })
    assert response(conn_post, :bad_request)
  end

  test "POST /api/posts/unstructured doesn't parse URL if in text", %{conn: conn} do
    conn_post = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts/unstructured", %{
      "subject" => "test heading",
      "body" => "this is some [md](https://md.com)\nwelike MD a lot\n\nhttps://md.com don't we\n",
    })
    assert response(conn_post, :created)

    html = html_response(get(conn, "/"), 200)
    assert !(html =~ "<a class=\"link\" href=\"https://md.com\">")
  end

  test "POST /api/posts/unstructured parses URL if alone", %{conn: conn} do
    conn_post = conn
    |> put_req_header("authorization", "Bearer secret")
    |> post("/api/posts/unstructured", %{
      "subject" => "test heading",
      "body" => "this is some [md](https://md.com)\nwelike MD a lot\n\n\n\n  https://example.com  \n\n",
    })
    assert response(conn_post, :created)

    assert html_response(get(conn, "/"), 200) =~ "<a class=\"link\" href=\"https://example.com\">"
  end
end
