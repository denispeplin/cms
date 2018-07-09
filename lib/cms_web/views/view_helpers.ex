defmodule CmsWeb.ViewHelpers do
  def dom_uuid(%{__struct__: struct, uuid: uuid}) do
    prefix = struct
    |> Atom.to_string
    |> String.split(".")
    |> List.last
    |> Macro.underscore
    Enum.join([prefix, uuid], "_")
  end
end
