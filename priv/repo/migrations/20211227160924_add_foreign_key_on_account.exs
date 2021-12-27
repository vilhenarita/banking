defmodule Banking.Repo.Migrations.AddForeignKeyOnAccount do
  use Ecto.Migration

  def change do
      alter table("accounts") do
        add :transaction_id, references(:transactions)
      end
  end
end
