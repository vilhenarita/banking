defmodule Banking.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

    # email deve ser unico, pois é usado no saque
    create unique_index(:users, [:email])
  end
end
