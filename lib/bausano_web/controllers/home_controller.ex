defmodule BausanoWeb.HomeController do
  use BausanoWeb, :controller
  alias Bausano.Post
  alias Bausano.Repo
  # Imports the "last" function.
  import Ecto.Query

  # Views a coach profile.
  def index(conn, _) do
    # TODO: Test what happens in production when this crashes.
    {:ok, posts} = Repo.transaction(fn() ->
      Enum.to_list(Repo.stream(from p in Post))
    end)

    render(conn, "index.html", posts: posts)
  end
end
