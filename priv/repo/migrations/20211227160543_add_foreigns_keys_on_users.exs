defmodule Banking.Repo.Migrations.AddForeignsKeysOnUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :profile_id, references(:profiles)
      add :account_id, references(:accounts)
    end
  end
end
