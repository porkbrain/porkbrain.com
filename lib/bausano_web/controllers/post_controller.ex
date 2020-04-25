defmodule BausanoWeb.PostController do
  use BausanoWeb, :controller
  alias Bausano.Post
  alias Bausano.Repo

  @create_post_schema %{
    "type" => "object",
    "required" => ["heading", "description"],
    "properties" => %{
      "heading" => %{
        "type" => "string"
      },
      "description" => %{
        "type" => "string"
      },
      "url" => %{
        "type" => "string"
      }
    }
  } |> ExJsonSchema.Schema.resolve()

  def create(conn, params) do
    case ExJsonSchema.Validator.validate(@create_post_schema, params) do
      {:error, errors} ->
        # Destructs the list of tuples to get the first error message.
        [{error, _} | _] = errors
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{ "message" => error })
        |> halt()
      :ok ->
        {:ok, _} = Repo.insert Post.changeset(%Post{}, %{
          "heading" => params["heading"],
          "description" => params["description"],
          "url" => params["url"]
        })
        conn
        |> send_resp(:created, "")
    end
  end
end
