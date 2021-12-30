defmodule Banking.TransactionTest do
  use Banking.DataCase, async: true

  @valid_attributes %{type: "Transferência", description: "exemplo de transferência", amount: 200}

  describe "changeset/1" do
    test "transaction with valid attributes" do
      transaction = Banking.Transaction.changeset(@valid_attributes)
      assert transaction.valid?
    end
  end

end
