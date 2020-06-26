# Release hooks that can be eval()'d at runtime
#
# Examples:
#
# mix release
#
# SECRET_KEY_BASE=$(mix phx.gen.secret) \
# DB_USERNAME=postgres \
# DB_PASSWORD=postgres \
# DB_NAME=liquid_voting_auth_dev \
# DB_HOST=localhost \
# _build/dev/rel/liquid_voting_auth/bin/liquid_voting_auth eval 'LiquidVotingAuth.Release.migrate'
#
# SECRET_KEY_BASE=$(mix phx.gen.secret) \
# DB_USERNAME=postgres \
# DB_PASSWORD=postgres \
# DB_NAME=liquid_voting_auth_dev \
# DB_HOST=localhost \
# _build/dev/rel/liquid_voting_auth/bin/liquid_voting_auth eval 'LiquidVotingAuth.Release.create_org("Bonafide Test Organization")'
#
defmodule LiquidVotingAuth.Release do
  @app :liquid_voting_auth

  alias LiquidVotingAuth.Organizations.Organization

  def migrate do
    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  def create_org(org_name) do
    for repo <- repos() do
      attrs = %{name: org_name}

      {:ok, org, _} =
        Ecto.Migrator.with_repo(repo, fn repo ->
          %Organization{}
          |> Organization.changeset(attrs)
          |> repo.insert!
        end)

      IO.puts("Organization #{org.name} created")
      IO.puts("Auth key: #{org.auth_key}")
    end
  end

  defp repos do
    Application.load(@app)
    Application.fetch_env!(@app, :ecto_repos)
  end
end
