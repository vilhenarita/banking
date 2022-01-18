defmodule Banking.Schemas.Profile do
  use Ecto.Schema

  import Ecto.Changeset
  import Brcpfcnpj.Changeset

  alias Banking.Schemas.User

  # Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "profiles" do
    field :name, :string
    field :cpf, :string
    belongs_to :user, User, type: :binary_id

    timestamps()
  end

  def create_changeset(params) do
    %__MODULE__{}
    |> cast(params, [:name, :cpf, :user_id])
    |> validate_required([:name, :cpf, :user_id])
    |> validate_cpf(:cpf)
    |> foreign_key_constraint(:user_id)
  end


end
