defmodule Banking.Transactions do
  alias Banking.Repo
  alias Banking.Schemas.Account
  alias Banking.Schemas.Transaction
  alias Banking.EmailSender
  alias Ecto.Multi

  import Ecto.Query

  def withdraw(account, amount, description \\ "") do
    Multi.new()
    |> Multi.run(:account, fn _repo, _args ->
      account_id = account.id

      Account
      |> where(id: ^account_id)
      |> lock("FOR UPDATE")
      |> Repo.one()
      |> case do
        nil ->
          {:error, :account_not_found}

        account ->
          account
          |> Account.withdraw_changeset(amount)
          |> Repo.update()
      end
    end)
    |> Multi.insert(
      :transaction,
      Transaction.create_changeset(%{
        type: :withdraw,
        amount: amount,
        description: description,
        account_id: account.id
      })
    )
    |> Multi.run(:email, fn _repo, %{transaction: transaction} ->
      EmailSender.notify_withdraw(account.user.email, transaction)
    end)
    |> Repo.transaction()
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
end
