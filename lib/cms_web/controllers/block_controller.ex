defmodule CmsWeb.BlockController do
  use CmsWeb, :controller
  alias Cms.Repo
  alias Cms.Content

  def update(conn, %{"id" => uuid} = params) do
    block = Cms.Content.Block
    |> Repo.get_by!(uuid: uuid)
    |> Content.Block.update_changeset(params)
    |> Repo.update!

    render conn, "update.json", block: block
  end
end
