defmodule Banking.User do
  use Ecto.Schema

  #Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :name,  :string
    field :cpf,   :string
    field :email, :string
    field :password_hash, :string
    field :balance,   :decimal

      timestamps()
  end

end
