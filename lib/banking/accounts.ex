defmodule Banking.Accounts do
  import Ecto.Query

  alias Banking.Repo
  alias Banking.Schemas.Account

  def get_account_by_email(email) do
    Account
    |> join(:inner, [a], u in assoc(a, :user))
    |> where([_a, u], u.email == ^email)
    |> preload(:user)
    |> Repo.one()
    |> case do
      nil -> {:error, :account_not_found}
      account -> {:ok, account}
    end
  end
end
