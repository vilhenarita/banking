defmodule Banking.Repo.Migrations.Account do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :balance, :integer
      add :user_id, references(:users)

      timestamps()
    end

    create constraint(:accounts, :balance_must_be_nonnegative, check: "balance >= 0")

  end
end
