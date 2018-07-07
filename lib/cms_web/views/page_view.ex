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
    content_tag :div, opts(edit_mode) do
      block
    end
  end

  defp opts(edit_mode) do
    [
      class: edit_mode |> editable? |> edit_class,
      contenteditable: editable?(edit_mode)
    ]
  end

  defp edit_class(false), do: ""
  defp edit_class(true), do: "editable"

  defp editable?(nil), do: editable?(false)
  defp editable?(false), do: false
  defp editable?(true), do: true
end
