
defmodule Banking.Users do


  alias Banking.Repo
  alias Banking.Schemas.User
  alias Banking.Schemas.Profile
  alias Banking.Schemas.Account
  alias Ecto.Multi

  def create_user(attrs \\ %{}) do
    Multi.new()
    |> Multi.insert(:user, User.create_changeset(attrs))
    |> Multi.insert(:profile, fn %{user: %User{id: user_id}} ->
      attrs
      |> Map.put(:user_id,user_id)
      |> Profile.create_changeset()
    end)
    |> Multi.insert(:account, fn %{user: %User{id: user_id}} ->
      attrs
      |> Map.put(:user_id,user_id)
      |> Account.create_changeset()
    end)
    |> Repo.transaction()
  end

  def get_user!(email), do: Repo.get_by(User, email: email)

end
