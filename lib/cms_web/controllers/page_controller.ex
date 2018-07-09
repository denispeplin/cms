defmodule CmsWeb.PageController do
  use CmsWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Cms.Repo

  @template "index"

  def index(conn, _params) do
    page = from(p in Cms.Content.Page,
      where: p.slug == "page-1",
      preload: [:blocks]
    )
    |> Repo.one!

    render conn, template_to_render(), page: page
  end

  def show(conn, %{"id" => slug}) do
    page = from(p in Cms.Content.Page,
      where: p.slug == ^slug,
      preload: [:blocks]
    )
    |> Repo.one!

    render conn, template_to_render(), page: page
  end

  defp template_to_render do
    Enum.join([@template, "html"], ".")
  end
end
