defmodule Banking.Repo.Migrations.Account do
  use Ecto.Migration

  def change do
    create table :accounts do
      add :number, :string
      add :balance, :integer




      timestamps()
    end


    create unique_index(:accounts,[:number])
  end
end
