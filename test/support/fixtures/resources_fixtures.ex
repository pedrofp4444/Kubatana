defmodule Kubatana.ResourcesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kubatana.Resources` context.
  """

  @doc """
  Generate a house.
  """
  def house_fixture(attrs \\ %{}) do
    {:ok, house} =
      attrs
      |> Enum.into(%{
        capacity: 42,
        name: "some name"
      })
      |> Kubatana.Resources.create_house()

    house
  end
end
