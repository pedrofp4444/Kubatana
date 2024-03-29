defmodule Kubatana.ResourcesTest do
  use Kubatana.DataCase

  alias Kubatana.Resources

  describe "houses" do
    alias Kubatana.Resources.House

    import Kubatana.ResourcesFixtures

    @invalid_attrs %{capacity: nil, name: nil}

    test "list_houses/0 returns all houses" do
      house = house_fixture()
      assert Resources.list_houses() == [house]
    end

    test "get_house!/1 returns the house with given id" do
      house = house_fixture()
      assert Resources.get_house!(house.id) == house
    end

    test "create_house/1 with valid data creates a house" do
      valid_attrs = %{capacity: 42, name: "some name"}

      assert {:ok, %House{} = house} = Resources.create_house(valid_attrs)
      assert house.capacity == 42
      assert house.name == "some name"
    end

    test "create_house/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_house(@invalid_attrs)
    end

    test "update_house/2 with valid data updates the house" do
      house = house_fixture()
      update_attrs = %{capacity: 43, name: "some updated name"}

      assert {:ok, %House{} = house} = Resources.update_house(house, update_attrs)
      assert house.capacity == 43
      assert house.name == "some updated name"
    end

    test "update_house/2 with invalid data returns error changeset" do
      house = house_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_house(house, @invalid_attrs)
      assert house == Resources.get_house!(house.id)
    end

    test "delete_house/1 deletes the house" do
      house = house_fixture()
      assert {:ok, %House{}} = Resources.delete_house(house)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_house!(house.id) end
    end

    test "change_house/1 returns a house changeset" do
      house = house_fixture()
      assert %Ecto.Changeset{} = Resources.change_house(house)
    end
  end
end
