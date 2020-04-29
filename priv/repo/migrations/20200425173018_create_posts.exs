defmodule Porkbrain.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :heading, :string
      add :description, :string, size: 2048
      add :url, :string

      timestamps()
    end

  end
end
