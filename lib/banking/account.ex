defmodule Banking.Account do
  use Ecto.Schema
  import Ecto.Changeset

  # Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "accounts" do
    field :number, :string
    field :balance, :integer, default: 100
    belongs_to :user, Banking.User, foreign_key: :user_id
    has_many :transactions, Banking.Transaction

    timestamps()
  end

  def create_changeset(account,params) do
    account
    |> changeset(params)
  end


  def changeset(account,params) do
    account
    |> cast(params, [:number, :balance,:user_id])
    |> cast_assoc(:user)
    |> validate_required([:number, :balance])
    |> foreign_key_constraint(:user_id)
  end
end
