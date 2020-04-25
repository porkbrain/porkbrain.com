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

    # Parses markdown into html for post descriptions.
    # TODO: Move this into a function and to the template.
    posts = Enum.map(posts, fn(post) ->
      %{post | description:
        case Earmark.as_html(post.description) do
          {:ok, parsed_md, _} -> parsed_md
          _ -> post.description
        end
      }
    end)

    render(conn, "index.html", posts: posts)
  end
end
