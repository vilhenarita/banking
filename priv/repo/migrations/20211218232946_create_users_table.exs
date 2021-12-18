defmodule Banking.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do

    create table :users do
      add :name,  :string
      add :cpf,   :string
      add :email, :string
      add :password_hash, :string
      add :balance,   :decimal

      timestamps()
    end

    #definindo cpf como unico, validação necessária para deposito inicial de 1k
    create unique_index(:users,[:cpf])
    #email também deve ser unico, pois é usado no saque
    create unique_index(:users,[:email])
  end
end
