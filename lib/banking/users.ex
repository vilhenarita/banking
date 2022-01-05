
defmodule Banking.Users do


  alias Banking.Repo
  alias Banking.User


  def create_user(attrs \\ %{}) do
    %User{}
    |> Repo.preload(:profile)
    |> Repo.preload(:account)
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end


end
