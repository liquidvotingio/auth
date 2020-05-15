defmodule LiquidVotingAuthWeb.AuthControllerTest do
  use LiquidVotingAuthWeb.ConnCase

  alias LiquidVotingAuth.Organizations

  describe "authorization header includes a registered auth key for an organization" do
    test "GET /_external-auth*", %{conn: conn} do
      {:ok, organization} = Organizations.create_organization(%{name: "Democratic Circus"})
      auth_key = organization.auth_key
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

  describe "authorization header includes unregistered auth key" do
    test "GET /_external-auth*", %{conn: conn} do
      auth_key = Ecto.UUID.generate
      conn = conn
        |> Plug.Conn.put_req_header("authorization", "Bearer " <> auth_key)
        |> get("/_external-auth")

      assert conn.status == 401
    end
  end

  describe "authorization header includes auth key in bad format" do
    test "GET /_external-auth*", %{conn: conn} do
      auth_key = "1nHSXC7/hJIO0yjjclx2TnxrtofcXCT+iBl2M7p2uThWNIRnsBxIqurrr66Vr22h"
      conn = conn
        |> Plug.Conn.put_req_header("authorization", "Bearer " <> auth_key)
        |> get("/_external-auth")

      assert conn.status == 401
    end
  end
end