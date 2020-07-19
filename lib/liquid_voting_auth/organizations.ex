defmodule LiquidVotingAuth.Organizations do
  @moduledoc """
  The Organizations context.
  """

  import Ecto.Query, warn: false

  alias LiquidVotingAuth.Repo
  alias LiquidVotingAuth.Organizations.Organization

  @doc """
  Returns the list of organizations.

  ## Examples

      iex> list_organizations()
      [%Organization{}, ...]

  """
  def list_organizations(), do: Repo.all(Organization)

  @doc """
  Gets a single organization.

  Raises `Ecto.NoResultsError` if the Organization does not exist.

  ## Examples

      iex> get_organization!(123)
      %Organization{}

      iex> get_organization!(456)
      ** (Ecto.NoResultsError)

  """
  def get_organization!(id), do: Repo.get!(Organization, id)

  @doc """
  Checks if an organization with given auth key exists

  ## Examples

    iex> get_organization_with_auth_key("aifsadf7234H")
    %Organization{}

    iex> get_organization_with_auth_key("badkey")
    nil
  """
  def get_organization_with_auth_key(auth_key) do
    Repo.get_by(Organization, auth_key: auth_key)
  rescue
    Ecto.Query.CastError -> nil
  end

  @doc """
  Creates a organization.

  ## Examples

      iex> create_organization(%{field: value})
      {:ok, %Organization{}}

      iex> create_organization(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a organization.

  ## Examples

      iex> update_organization(organization, %{field: new_value})
      {:ok, %Organization{}}

      iex> update_organization(organization, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_organization(%Organization{} = organization, attrs) do
    organization
    |> Organization.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a organization.

  ## Examples

      iex> delete_organization(organization)
      {:ok, %Organization{}}

      iex> delete_organization(organization)
      {:error, %Ecto.Changeset{}}

  """
  def delete_organization(%Organization{} = organization), do: Repo.delete(organization)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking organization changes.

  ## Examples

      iex> change_organization(organization)
      %Ecto.Changeset{data: %Organization{}}

  """
  def change_organization(%Organization{} = organization, attrs \\ %{}),
    do: Organization.changeset(organization, attrs)
end
