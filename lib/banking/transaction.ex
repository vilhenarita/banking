defmodule Banking.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  # campos que podem ser alterados
  @changeable_fields [
    :type,
    :description,
    :amount
  ]

  # campos obrigatórios
  @required_fields [
    :type,
    :description,
    :amount
  ]

  # Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "transactions" do
    field :type, :string
    field :description, :string
    field :amount, :integer
    belongs_to :account, Banking.Account

    timestamps()
  end

  def changeset(%{} = params) do
    %__MODULE__{}
    |> cast(params, @changeable_fields)
    |> validate_required(@required_fields)
  end
end
