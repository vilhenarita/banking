defmodule Banking.Schemas.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Banking.Schemas.Profile
  alias Banking.Schemas.Account



  # Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_one :profile, Profile
    has_one :account, Account

    timestamps()
  end


  def create_changeset(params) do
    %__MODULE__{}
    |> cast(params, [:email,:password])
    |> validate_required([:email])
    |> validate_length(:password_hash, min: 8)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_required(:password)
    |> put_password_hash
  end


  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
