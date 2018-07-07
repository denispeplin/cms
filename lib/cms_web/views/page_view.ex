defmodule CmsWeb.PageView do
  use CmsWeb, :view

  # TODO: code is ineffective, group blocks in controller and fetch texts to fix this
  # (make deep map with page and blocks grouped by name)
  def render_block(page, name, edit_mode) do
    Enum.find(page.blocks, fn(block) ->
      block.name == Atom.to_string(name)
    end)
    |> Map.fetch!(:text)
    |> HtmlSanitizeEx.strip_tags
    |> String.replace("\n", "<br>\n")
    |> raw
    |> wrap_block(edit_mode)
  end

  defp wrap_block(block, edit_mode) do
    content_tag :div, class: edit_class(edit_mode) do
      block
    end
  end

  defp edit_class(nil), do: edit_class(false)
  defp edit_class(false), do: ""
  defp edit_class(true), do: "editable"
end
