defmodule LiquidVotingAuth.OrganizationsTest do
  use LiquidVotingAuth.DataCase

  alias LiquidVotingAuth.Organizations

  describe "organizations" do
    alias Organizations.Organization

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Organizations.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Organizations.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Organizations.get_organization!(organization.id) == organization
    end

    test "get_organization_with_auth_key/1 returns org id when organization is found with given auth key" do
      organization = organization_fixture()
      assert Organizations.get_organization_with_auth_key(organization.auth_key) == organization
    end

    test "get_organization_with_auth_key/1 returns nil when organization is not found with given auth key" do
      unregistered_auth_key = Ecto.UUID.generate()
      assert Organizations.get_organization_with_auth_key(unregistered_auth_key) == nil
    end

    test "get_organization_with_auth_key/1 returns nil when given auth key isn't a Ecto.UUID" do
      bad_format_auth_key = "1nHSXC7/hJIO0yjjclx2TnxrtofcXCT+iBl2M7p2uThWNIRnsBxIqurrr66Vr22h"
      assert Organizations.get_organization_with_auth_key(bad_format_auth_key) == nil
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} =
               Organizations.create_organization(@valid_attrs)

      assert organization.name == "some name"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()

      assert {:ok, %Organization{} = organization} =
               Organizations.update_organization(organization, @update_attrs)

      assert organization.name == "some updated name"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Organizations.update_organization(organization, @invalid_attrs)

      assert organization == Organizations.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Organizations.delete_organization(organization)

      assert_raise Ecto.NoResultsError, fn ->
        Organizations.get_organization!(organization.id)
      end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Organizations.change_organization(organization)
    end
  end
end
