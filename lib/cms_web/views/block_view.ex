defmodule CmsWeb.BlockView do
  use CmsWeb, :view

  def render("update.json", %{block: block}) do
    %{
      text: Helpers.parse_text(block.text)
    }
  end
end
