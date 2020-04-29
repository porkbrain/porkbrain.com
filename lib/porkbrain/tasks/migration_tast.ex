defmodule Porkbrain.ReleaseTasks do
  def migrate do
    {:ok, _} = Application.ensure_all_started(:porkbrain)

    path = Application.app_dir(:porkbrain, "priv/repo/migrations")

    Ecto.Migrator.run(Porkbrain.Repo, path, :up, all: true)
  end
end
