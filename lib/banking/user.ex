defmodule Banking.User do
  use Ecto.Schema
  import Ecto.Changeset

  #campos que podem ser alterados
  @changeable_fields [
    :name,
    :cpf,
    :email,
    :password_hash,
    :balance
  ]

  #campos obrigatórios
  @required_fields [
    :name,
    :cpf,
    :email,
    :password_hash
  ]

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

  def changeset(%{} = params) do
    %__MODULE__{}
    |> cast(params,@changeable_fields)
    |> validate_required(@required_fields)
    |> validate_length(:password_hash,min: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:cpf)
  end

end
