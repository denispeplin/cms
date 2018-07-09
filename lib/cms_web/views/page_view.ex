defmodule CmsWeb.PageView do
  use CmsWeb, :view

  # TODO: code is ineffective, group blocks in controller and fetch texts to fix this
  # (make deep map with page and blocks grouped by name)
  def render_block(conn, page, name) do
    Enum.find(page.blocks, fn(block) ->
      block.name == Atom.to_string(name)
    end)
    |> wrap_block(conn)
  end

  defp wrap_block(block, conn) do
    edit_mode = get_session(conn, :edit_mode)
    text = block.text
    |> Helpers.parse_text()
    |> raw
    path = block_path(conn, :update, block.uuid)
    dom_uuid = dom_uuid(block)
    content_tag :div, id: dom_uuid do
      [
        content_tag(:div, text, opts(edit_mode)),
        content_tag(:div, edit_mode |> editable? |> form(dom_uuid, path))
      ]
    end
  end

  defp form(false, _dom_uuid, _path), do: ""
  defp form(true, dom_uuid, path) do
    content_tag :form, class: :block_form, action: path, method: :post,
      "ujs-remote": true, data: [dom_uuid: dom_uuid] do
      [
        content_tag(:input, "", value: "put", name: "_method", hidden: true),
        content_tag(:textarea, "", class: "hiddenTextarea", name: "text", hidden: true),
        content_tag(:button, "Update", type: :submit)
      ]
    end
  end

  defp opts(edit_mode) do
    edit_class = edit_mode |> editable? |> edit_class()
    [
      class: Enum.join([edit_class, "blockContentEditable"], " "),
      contenteditable: editable?(edit_mode)
    ]
  end

  defp edit_class(false), do: ""
  defp edit_class(true), do: "editable"

  defp editable?(nil), do: editable?(false)
  defp editable?(false), do: false
  defp editable?(true), do: true
end
