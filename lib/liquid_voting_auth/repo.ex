defmodule LiquidVotingAuth.Repo do
  use Ecto.Repo,
    otp_app: :liquid_voting_auth,
    adapter: Ecto.Adapters.Postgres
end
