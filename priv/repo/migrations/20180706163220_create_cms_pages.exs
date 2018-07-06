defmodule Cms.Repo.Migrations.CreateCmsPages do
  use Ecto.Migration

  def change do
    create table(:content_pages) do
      add :template, :string, null: false

      timestamps()
    end

    create index(:content_pages, :template, unique: true)
  end
end
