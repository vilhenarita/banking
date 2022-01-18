defmodule Banking.AccountTest do
  use Banking.DataCase, async: true

  alias Banking.Accounts

  test "get_account_by_email/1 with an existent email" do

    valid_email = "teste@teste"

    assert {:ok, Accounts.get_account_by_email(valid_email)}
  end

  test "get_account_by_email/1 with an invalid email" do

    invalid_email = "teste@testando"

    assert {:error, Accounts.get_account_by_email(invalid_email)}
  end

end
