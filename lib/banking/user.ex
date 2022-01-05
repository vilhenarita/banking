defmodule Banking.User do
  use Ecto.Schema
  import Ecto.Changeset


  # Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_one :profile, Banking.Profile
    has_one :account, Banking.Account

    timestamps()
  end

  def create_changeset(user,params) do
    user
    |> changeset(params)
    |> validate_required(:password)
  end


  def changeset(user,params) do
    user
    |> cast(params, [:email,:password])
    |> validate_required([:email])
    |> validate_length(:password_hash, min: 8)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_password_hash
  end


  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
