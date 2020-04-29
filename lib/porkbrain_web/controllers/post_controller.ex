defmodule PorkbrainWeb.PostController do
  use PorkbrainWeb, :controller
  alias Porkbrain.Post
  alias Porkbrain.Repo

  # To create a new post, one needs an API key.
  plug PorkbrainWeb.Plugs.Authorization

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

  @create_post_unstructured_schema %{
    "type" => "object",
    "properties" => %{
      "subject" => %{
        "type" => "string"
      },
      "body" => %{
        "type" => "string"
      }
    }
  } |> ExJsonSchema.Schema.resolve()

  # Creates a new post from received unstructured data. This endpoint is useful
  # to forward emails to for example.
  #
  # It will try look for a URL in the body and use that as the post url. The
  # rest of the body will be used as description.
  def create_unstructured(conn, params) do
    case ExJsonSchema.Validator.validate(@create_post_unstructured_schema, params) do
      {:error, errors} ->
        # Destructs the list of tuples to get the first error message.
        [{error, _} | _] = errors
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{ "message" => error })
        |> halt()
      :ok ->
        into_string = fn value ->
          if String.valid?(value) do String.trim(value) else "" end
        end

        heading = into_string.(params["subject"])
        body = into_string.(params["body"])

        # If there isn't any content sent, fail the request.
        if String.length(heading) + String.length(body) == 0 do
          conn
          |> put_status(:bad_request)
          |> json(%{ "message" => "Empty payload." })
          |> halt()
        else
          url_regex = ~r/^(http|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])?$/
          # Split by new lines and gets first line that has a url.
          url = String.split(body, "\n", trim: true)
          |> Enum.find("", fn body_part ->
            String.match?(String.trim(body_part), url_regex)
          end)

          # Removes url from the description if any was found.
          description = if url == nil do
            body
          else
            String.replace(body, url, "", global: false)
          end

          {:ok, _} = Repo.insert Post.changeset(%Post{}, %{
            "heading" => String.trim(heading),
            "description" => String.trim(description),
            "url" => String.trim(url)
          })

          send_resp(conn, :created, "")
        end
      end
  end
end
