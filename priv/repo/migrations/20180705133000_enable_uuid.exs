defmodule Cms.Repo.Migrations.EnableUuid do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""
  end
end
