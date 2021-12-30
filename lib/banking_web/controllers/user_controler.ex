defmodule BankingWeb.UserController do
  use BankingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end
end
