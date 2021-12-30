defmodule Banking.AccountTest do
  use Banking.DataCase, async: true

  @valid_attributes %{number: "12345", balance: 100}

  describe "changeset/1" do
    test "account with valid attributes" do
      account = Banking.Account.changeset(@valid_attributes)
      assert account.valid?
    end
  end

end
