defmodule LiquidVotingAuthWeb.AuthControllerTest do
  use LiquidVotingAuthWeb.ConnCase

  describe "authorization header includes our demo auth key" do
    test "GET /_external-auth*", %{conn: conn} do
      auth_key = "1nHSXC7/hJIO0yjjclx2TnxrtofcXCT+iBl2M7p2uThWNIRnsBxIqurrr66Vr22h"
      conn = conn
        |> Plug.Conn.put_req_header("authorization", "Bearer " <> auth_key)
        |> get("/_external-auth")

      assert conn.status == 200
    end
  end

  describe "no authorization header" do
    test "GET /_external-auth*", %{conn: conn} do
      conn = conn
        |> get("/_external-auth")

      assert conn.status == 401
    end
  end

  describe "bad authorization header" do
    test "GET /_external-auth*", %{conn: conn} do
      auth_key = "bad auth key"
      conn = conn
        |> Plug.Conn.put_req_header("authorization", "Bearer " <> auth_key)
        |> get("/_external-auth")

      assert conn.status == 401
    end
  end
end