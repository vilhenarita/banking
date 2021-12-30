defmodule Banking.Profile do
  use Ecto.Schema
  import Ecto.Changeset
  import Brcpfcnpj.Changeset


  # campos que podem ser alterados
  @changeable_fields [
    :name,
    :cpf
  ]

  # campos obrigatórios
  @required_fields [
    :name,
    :cpf
  ]

  # Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "profiles" do
    field :name, :string
    field :cpf, :string
    belongs_to :user, Banking.User

    timestamps()
  end

  def changeset(%{} = params) do
    %__MODULE__{}
    |> cast(params, @changeable_fields)
    |> validate_required(@required_fields)
    |> validate_cpf(:cpf)
  end
end
