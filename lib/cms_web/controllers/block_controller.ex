defmodule CmsWeb.BlockController do
  use CmsWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Cms.Repo
  alias Cms.Content

  def update(conn, params) do
    block = from(b in Cms.Content.Block, [])
    |> Repo.one!
    |> Content.Block.update_changeset(params)
    |> Repo.update!

    render conn, "update.json", block: block
  end
end
