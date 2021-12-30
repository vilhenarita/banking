defmodule Banking.UserTest do
  use Banking.DataCase, async: true

  @valid_attributes %{email: "teste@teste", password_hash: "asd123123"}

  describe "changeset/1" do
    test "user with valid attributes" do
      user = Banking.User.changeset(@valid_attributes)
      assert user.valid?
    end
  end

end
