# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cms.Repo.insert!(%Cms.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Cms.Repo.transaction fn ->
  page = Cms.Repo.insert!(%Cms.Content.Page{template: "index"})
  Cms.Repo.insert!(%Cms.Content.Block{name: "first", text: "1st block\ntext", page_id: page.id})
  Cms.Repo.insert!(%Cms.Content.Block{name: "second", text: "2nd block\ntext", page_id: page.id})
end
