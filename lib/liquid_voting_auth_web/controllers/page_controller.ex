defmodule LiquidVotingAuthWeb.PageController do
  use LiquidVotingAuthWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
