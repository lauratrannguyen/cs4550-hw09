defmodule EventsappWeb.PageController do
  use EventsappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
