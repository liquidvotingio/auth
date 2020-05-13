defmodule LiquidVotingAuthWeb.AuthController do
  use LiquidVotingAuthWeb, :controller

  alias LiquidVotingAuth.Organizations

  def index(conn, _params) do
    with(
      [header_value] <- get_req_header(conn, "authorization"),
      {:ok, auth_key} <- get_bearer(header_value)
    ) do
      if registered?(auth_key) do
        conn |> send_resp(200, "")
      else
        conn |> send_resp(401, "")
      end
    else
      _ -> conn |> send_resp(401, "")
    end
  end

  defp registered?(auth_key) do
    Organizations.exists_with_auth_key?(auth_key)
  end

  defp get_bearer(header_value) do
    with(
      [method, auth_key] <- String.split(header_value, " ", parts: 2),
      "bearer" <- String.downcase(method)
    ) do
      {:ok, auth_key}
    else
      _ -> {:error, :no_bearer}
    end
  end
end
