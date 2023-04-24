defmodule KlendarWeb.PageController do
  use KlendarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
