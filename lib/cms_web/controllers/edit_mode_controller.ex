defmodule CmsWeb.EditModeController do
  use CmsWeb, :controller

  def create(conn, _params) do
    conn
    |> put_session(:edit_mode, true)
    |> redirect_to_referer
  end

  def delete(conn, _params) do
    conn
    |> put_session(:edit_mode, false)
    |> redirect_to_referer
  end

  defp redirect_to_referer(conn) do
    %URI{path: path} = conn
    |> get_req_header("referer")
    |> List.first
    |> URI.parse
    redirect(conn, to: path)
  end
end
