defmodule Cms.Repo.Migrations.CreateCmsBlocks do
  use Ecto.Migration

  def change do
    create table(:content_blocks) do
      add :uuid, :uuid, null: false, default: fragment("uuid_generate_v4()")
      add :name, :string, null: false
      add :text, :text, null: false
      add :page_id, references(:content_pages, on_delete: :nothing)

      timestamps()
    end

    create index(:content_blocks, [:page_id])
    create index(:content_blocks, [:page_id, :name], unique: true)
  end
end
