defmodule CmsWeb.PageController do
  use CmsWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Cms.Repo

  @template "index"

  plug :get_latest_pages

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

  def get_latest_pages(conn, _opts) do
    pages = from(p in Cms.Content.Page,
      order_by: [desc: p.inserted_at],
      limit: 3
    ) |> Repo.all
    assign conn, :latest_pages, pages
  end
end
