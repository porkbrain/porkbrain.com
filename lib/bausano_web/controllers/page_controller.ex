defmodule BausanoWeb.PageController do
  use BausanoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
