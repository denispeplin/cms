defmodule CmsWeb.PageView do
  use CmsWeb, :view

  # TODO: code is ineffective, group blocks in controller and fetch texts to fix this
  # (make deep map with page and blocks grouped by name)
  def render_block(page, name, edit_mode) do
    Enum.find(page.blocks, fn(block) ->
      block.name == Atom.to_string(name)
    end)
    |> Map.fetch!(:text)
    |> Helpers.parse_text()
    |> raw
    |> wrap_block(edit_mode)
  end

  defp wrap_block(block, edit_mode) do
    content_tag :div do
      [
        content_tag(:div, block, opts(edit_mode)),
        content_tag(:div, edit_mode |> editable? |> form())
      ]
    end
  end

  # TODO: use block_path
  defp form(false), do: ""
  defp form(true) do
    content_tag :form, id: :block_form, action: "/blocks", method: :post, "ujs-remote": true do#, "ujs-method": :post do
      [
        content_tag(:input, "", value: "put", name: "_method", hidden: true),
        content_tag(:textarea, "", id: "hiddenTextarea", name: "text", hidden: true),
        content_tag(:button, "Update", type: :submit)
      ]
    end
  end

  defp opts(edit_mode) do
    [
      id: "blockContentEditable",
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
