defmodule LiquidVotingAuth.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :auth_key, :uuid, null: false
      add :name, :string

      timestamps()
    end

    create unique_index(:organizations, [:auth_key])
  end
end
