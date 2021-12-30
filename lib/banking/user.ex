defmodule Banking.User do
  use Ecto.Schema
  import Ecto.Changeset

  # campos que podem ser alterados
  @changeable_fields [
    :email,
    :password_hash
  ]

  # campos obrigatórios
  @required_fields [
    :email,
    :password_hash
  ]

  # Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, :string
    field :password_hash, :string
    has_one :profile, Banking.Profile
    has_one :account, Banking.Account

    timestamps()
  end

  def changeset(%{} = params) do
    %__MODULE__{}
    |> cast(params, @changeable_fields)
    |> validate_required(@required_fields)
    |> validate_length(:password_hash, min: 8)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
