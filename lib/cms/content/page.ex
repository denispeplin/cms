defmodule Cms.Content.Page do
  use Ecto.Schema
  import Ecto.Changeset


  schema "content_pages" do
    field :title, :string
    field :slug, :string
    field :template, :string

    has_many :blocks, Cms.Content.Block

    timestamps()
  end

  @doc false
  # TODO: handle non-unique slugs
  def changeset(page, attrs) do
    attrs = Map.put(attrs, :slug, slugify(attrs[:title]))
    |> IO.inspect
    page
    |> cast(attrs, [:template, :title, :slug])
    |> validate_required([:template, :title, :slug])
  end

  defp slugify(nil), do: nil
  defp slugify(text), do:  Slugger.slugify_downcase(text)
end
