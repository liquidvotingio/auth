defmodule LiquidVotingAuthWeb.AuthController do
  use LiquidVotingAuthWeb, :controller

  @demo_auth_key "1nHSXC7/hJIO0yjjclx2TnxrtofcXCT+iBl2M7p2uThWNIRnsBxIqurrr66Vr22h"

  def index(conn, _params) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> @demo_auth_key] ->
        conn |> send_resp(200, "")
      _ ->
        conn |> send_resp(401, "")
    end
  end
end
