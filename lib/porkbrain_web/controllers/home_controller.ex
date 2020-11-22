defmodule PorkbrainWeb.HomeController do
  use PorkbrainWeb, :controller
  alias Porkbrain.Post
  alias Porkbrain.Repo
  # Imports the "last" function.
  import Ecto.Query

  # Views the home page, which is a HN-like list.
  def index(conn, _) do
    {:ok, posts} = Repo.transaction(fn() ->
      Enum.to_list(Repo.stream(from p in Post, order_by: [
        {:desc, p.inserted_at},
        {:desc, p.id},
      ]))
    end)

    conn
    |> put_resp_header("cache-control", "public, max-age=3600")
    |> render("index.html", posts: posts)
  end

  def tribute(conn, _) do
    conn
    |> assign(:page_title, "un hommage à l'artiste")
    |> render("tribute.html")
  end
end
