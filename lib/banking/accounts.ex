defmodule Banking.Accounts do
  import Ecto.Query, warn: false

  alias Banking.Repo
  alias Banking.Schemas.User


  def get_account_by_email(email) do
    case Repo.get_by(User, email: email) |> Repo.preload(:account) do
      nil ->
        {:error, :account_not_found}

      user ->
        {:ok, user}
    end
  end


end
