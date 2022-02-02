defmodule Banking.AccountsTest do
  use Banking.DataCase, async: true

  alias Banking.Accounts
  alias Banking.Schemas.Account
  alias Banking.Schemas.User

  describe "get_account_by_email/1" do
    test "get_account_by_email/1 with an existent email" do
      valid_email = "teste@teste"

      user =
        %{email: valid_email, password: "asd123123"}
        |> User.create_changeset()
        |> Repo.insert!()

      %{balance: 2000, user_id: user.id}
      |> Account.create_changeset()
      |> Repo.insert!()

      assert {:ok, %Account{} = account} = Accounts.get_account_by_email(valid_email)
      assert account.user.email == valid_email
    end

    test "get_account_by_email/1 with an invalid email" do
      invalid_email = "teste@testando"

      assert {:error, :account_not_found} = Accounts.get_account_by_email(invalid_email)
    end
  end
end
