defmodule Porkbrain.Repo do
  use Ecto.Repo,
    otp_app: :porkbrain,
    adapter: Ecto.Adapters.Postgres
end
