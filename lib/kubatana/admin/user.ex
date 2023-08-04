defmodule Kubatana.Admin.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    field :age, :integer
    field :house, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :age, :house])
    |> validate_required([:name, :age, :house])
  end
end
