defmodule Bausano.Repo do
  use Ecto.Repo,
    otp_app: :bausano,
    adapter: Ecto.Adapters.Postgres
end
