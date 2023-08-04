defmodule Kubatana.AdminTest do
  use Kubatana.DataCase

  alias Kubatana.Admin

  describe "members" do
    alias Kubatana.Admin.User

    import Kubatana.AdminFixtures

    @invalid_attrs %{age: nil, house: nil, name: nil}

    test "list_members/0 returns all members" do
      user = user_fixture()
      assert Admin.list_members() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Admin.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{age: 42, house: "some house", name: "some name"}

      assert {:ok, %User{} = user} = Admin.create_user(valid_attrs)
      assert user.age == 42
      assert user.house == "some house"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{age: 43, house: "some updated house", name: "some updated name"}

      assert {:ok, %User{} = user} = Admin.update_user(user, update_attrs)
      assert user.age == 43
      assert user.house == "some updated house"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_user(user, @invalid_attrs)
      assert user == Admin.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Admin.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Admin.change_user(user)
    end
  end
end
