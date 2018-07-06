defmodule CmsWeb.PageView do
  use CmsWeb, :view

  # TODO: code is ineffective, group blocks in controller and fetch texts to fix this
  # (make deep map with page and blocks grouped by name)
  def render_block(page, name) do
    Enum.find(page.blocks, fn(block) ->
      block.name == Atom.to_string(name)
    end)
    |> Map.fetch!(:text)
    |> HtmlSanitizeEx.strip_tags
    |> String.replace("\n", "<br>\n")
    |> raw
  end
end
