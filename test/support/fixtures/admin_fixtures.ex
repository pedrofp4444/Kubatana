defmodule Kubatana.AdminFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kubatana.Admin` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        house: "some house",
        name: "some name"
      })
      |> Kubatana.Admin.create_user()

    user
  end
end
