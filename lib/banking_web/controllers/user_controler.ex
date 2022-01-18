defmodule BankingWeb.UserController do
  use BankingWeb, :controller
  alias Banking.Schemas.User
  alias Banking.Users

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

end
