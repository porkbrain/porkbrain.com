defmodule PorkbrainWeb.HomeController do
  use PorkbrainWeb, :controller
  alias Porkbrain.Post
  alias Porkbrain.Repo
  # Imports the "last" function.
  import Ecto.Query

  # Views the home page, which is a HN-like list.
  def index(conn, _) do
    # TODO: Test what happens in production when this crashes.
    {:ok, posts} = Repo.transaction(fn() ->
      Enum.to_list(Repo.stream(from p in Post, order_by: [
        {:desc, p.inserted_at},
        {:desc, p.id},
      ]))
    end)

    render(conn, "index.html", posts: posts)
  end

  def tribute(conn, _) do
    conn
    # |> put_layout(false)
    |> assign(:page_title, "un hommage à l'artiste")
    |> render("tribute.html")
  end
end
