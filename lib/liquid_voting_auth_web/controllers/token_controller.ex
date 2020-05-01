defmodule LiquidVotingAuthWeb.TokenController do
  use LiquidVotingAuthWeb, :controller

  @demo_token "1nHSXC7/hJIO0yjjclx2TnxrtofcXCT+iBl2M7p2uThWNIRnsBxIqurrr66Vr22h"

  def index(conn, _params) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> @demo_token] ->
        conn |> put_status(200)
      _ ->
        conn |> put_status(401)
    end
  end
end
