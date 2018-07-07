defmodule CmsWeb.Helpers do
  use CmsWeb, :view

  def parse_text(text) do
    text
    |> HtmlSanitizeEx.strip_tags
    |> String.replace("\n", "<br>\n")
  end
end
