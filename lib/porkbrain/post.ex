# APIs for working with generic posts. Posts are displayed at
# homepage. Other logic might use these posts to include them in
# whatever it is doing. Post is kind of like quote or reference.
# The purpose is to have something that holds a heading and some short
# description, have optionally a link associated with it, and
# reusable.
#
# Since it's displayed at homepage, there will be an overview of
# what's being posted to the website.

defmodule Porkbrain.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :description, :string
    field :heading, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:heading, :description, :url])
  end
end
