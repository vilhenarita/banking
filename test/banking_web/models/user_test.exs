defmodule Banking.UserTest do
  use Banking.DataCase, async: false

  alias Banking.Repo
  alias Banking.Users
  alias Banking.Schemas.User
  alias Banking.Schemas.Profile
  alias Banking.Schemas.Account

  test "create_user/1 with valid data creates a user" do

    valid_attributes = %{
      email: Faker.Internet.email(),
      password: "asd123123",
      name: Faker.Person.name(),
      cpf: Brcpfcnpj.cpf_generate()
    }

    assert {:ok, %{user: %User{} = user, profile: %Profile{} = profile, account: %Account{} = account}} = Users.create_user(valid_attributes)

    assert user.email == valid_attributes.email
    refute user.password_hash == valid_attributes.password
    refute is_nil(user.password_hash)

    assert profile.name == valid_attributes.name
    assert Brcpfcnpj.cpf_valid?(profile.cpf)

    assert account.balance == 1000_00

    assert Repo.aggregate(User, :count) == 1
    assert Repo.aggregate(Profile, :count) == 1
    assert Repo.aggregate(Account, :count) == 1


  end
end
