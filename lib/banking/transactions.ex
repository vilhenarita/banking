defmodule Banking.Transactions do

  alias Banking.Repo
  alias Banking.Schemas.Account
  alias Banking.Schemas.Transaction
  alias Ecto.Multi

  import Ecto.Query


  def list_accounts do
    Repo.all(Account)
  end

  def list_transactions do
    Repo.all(Transaction)
  end

  def get_transaction!(id), do: Repo.get!(Transaction, id)

  def withdraw(account, amount, description \\ "") do
    Multi.new()
    |> Multi.run(:account, fn _repo, _args ->
      account_id = account.id

      Account
      |> where(id: ^account_id)
      |> lock("FOR UPDATE")
      |> Repo.one()
      |> case do
        nil -> {:error, :account_not_found}
        account ->
          account
          |> Account.withdraw_changeset(amount)
          |> Repo.update()
      end
    end)
    |> Multi.insert(:transaction, Transaction.create_changeset(%{type: :withdraw, amount: amount, description: description, account_id: account.id}))
    |> Repo.transaction()
  end

  def valid_transaction?(account, amount) do
    case valid_withdraw_from_account?(account, amount) do
      true -> {:ok, account}
      _ -> {:error}
    end
  end

  # def transfer_to(account, receiver, amount) do
  #   account
  #   |> create_transaction(amount, "transfer")

  #   receiver
  #   |> Account.deposit_changeset(%{amount: amount})
  #   |> Repo.update()

  #   account
  #   |> Account.withdraw_changeset(%{amount: amount})
  #   |> Repo.update()
  # end

  defp valid_withdraw_from_account?(account, amount) do
    account.balance - amount >= 0
  end

end
