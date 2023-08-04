defmodule Kubatana.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :name, :string
      add :age, :integer
      add :house, :string

      timestamps()
    end
  end
end
