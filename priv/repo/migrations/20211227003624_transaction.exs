defmodule Banking.Repo.Migrations.Transaction do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :type, :string
      add :description, :string
      add :amount, :integer
      add :account_id, references(:accounts)

      timestamps()
    end
  end
end
