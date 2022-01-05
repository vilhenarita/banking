defmodule Banking.UserTest do
  use Banking.DataCase, async: true

  alias Banking.Users
  alias Banking.User

  @valid_attributes %{email: "teste@teste", password: "asd123123", name: "Rita", cpf: "376.113.470-39", number: "1234"}



  #describe "changeset/1" do
  # test "user with valid attributes" do
  #    user = Banking.User.create_changeset(@valid_attributes)
  #    assert user.valid?
  #  end
  #end

  test "create_user/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = Users.create_user(@valid_attributes)
    assert user.email == "teste@teste"
    refute user.password_hash == "asd123123"
    assert user.password_hash != nil

  end



end
