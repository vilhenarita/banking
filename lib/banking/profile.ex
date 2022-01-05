defmodule Banking.Profile do
  use Ecto.Schema
  import Ecto.Changeset
  import Brcpfcnpj.Changeset



  # Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "profiles" do
    field :name, :string
    field :cpf, :string
    belongs_to :user, Banking.User, foreign_key: :user_id

    timestamps()
  end

  def create_changeset(profile,params) do
    profile
    |> changeset(params)
  end


  def changeset(profile,params) do
    profile
    |> cast(params, [:name,:cpf,:user_id])
    |> cast_assoc(:user)
    |> validate_required([:name,:cpf])
    |> validate_cpf(:cpf)
    |> foreign_key_constraint(:user_id)
  end
end
