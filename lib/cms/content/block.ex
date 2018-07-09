defmodule Cms.Content.Block do
  use Ecto.Schema
  import Ecto.Changeset


  schema "content_blocks" do
    field :uuid, :binary_id, read_after_writes: true
    field :name, :string
    field :text, :string
    field :page_id, :id

    timestamps()
  end

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, [:name, :text])
    |> validate_required([:name, :text])
  end

  def update_changeset(block, attrs) do
    block
    |> cast(attrs, [:text])
    |> validate_required([:name, :text])
  end
end
