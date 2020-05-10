defmodule LiquidVotingAuthWeb.TokenControllerTest do
  use LiquidVotingAuthWeb.ConnCase

  describe "authorization header includes our demo token" do
    test "GET /_external-auth*", %{conn: conn} do
      token = "1nHSXC7/hJIO0yjjclx2TnxrtofcXCT+iBl2M7p2uThWNIRnsBxIqurrr66Vr22h"
      conn = conn
        |> Plug.Conn.put_req_header("authorization", "Bearer " <> token)
        |> get("/_external-auth")

      assert conn.status == 200
    end
  end

  describe "no authorization header" do
    
  end

  describe "bad authorization header" do
    
  end
end