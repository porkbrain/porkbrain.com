# This plug can be used to authorize endpoints which can be called by external
# services such as Automate.io.

defmodule PorkbrainWeb.Plugs.Authorization do
  import Plug.Conn

  # Grabs the API token from the env vars.
  def init([]), do: "Bearer " <> Application.get_env(:porkbrain, :api_token)

  def call(%Plug.Conn{req_headers: headers} = conn, authorization_header) do
    if Enum.any?(headers, fn {name, value} ->
      name == "authorization" && value == authorization_header
    end) do
      conn
    else
      conn
      |> send_resp(:unauthorized, "")
      |> halt()
    end
  end
end
