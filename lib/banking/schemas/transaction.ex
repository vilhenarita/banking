defmodule Banking.Schemas.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Banking.Schemas.Account


  # Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "transactions" do
    field :type, Ecto.Enum, values: [:transfer, :withdraw]
    field :description, :string
    field :amount, :integer
    belongs_to :account, Account, type: :binary_id

    timestamps()
  end

  def create_changeset(params) do
    %__MODULE__{}
    |> cast(params, [:type, :description, :amount, :account_id])
    |> validate_required([:type, :description, :amount, :account_id])
    |> foreign_key_constraint(:account_id)
  end

end
