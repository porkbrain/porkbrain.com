defmodule Bausano.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :heading, :string
      add :description, :string
      add :url, :string

      timestamps()
    end

  end
end
