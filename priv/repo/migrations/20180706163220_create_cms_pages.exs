defmodule Cms.Repo.Migrations.CreateCmsPages do
  use Ecto.Migration

  def change do
    create table(:content_pages) do
      add :title, :string, null: false
      add :slug, :string, null: false
      add :template, :string, null: false

      timestamps()
    end

    create index(:content_pages, :slug, unique: true)
    create index(:content_pages, :template)
  end
end
