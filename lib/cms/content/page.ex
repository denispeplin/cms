defmodule Cms.Content.Page do
  use Ecto.Schema
  import Ecto.Changeset


  schema "content_pages" do
    field :template, :string

    has_many :blocks, Cms.Content.Block

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:template])
    |> validate_required([:template])
  end
end
