defmodule Banking.Schemas.Account do
  use Ecto.Schema

  import Ecto.Changeset

  alias Banking.Schemas.User
  alias Banking.Schemas.Transaction

  # Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "accounts" do
    #balance é dado em centavos
    field :balance, :integer, default: 100000, read_after_writes: true
    belongs_to :user, User, type: :binary_id
    has_many :transactions, Transaction

    timestamps()
  end

  def create_changeset(params) when is_map(params) do
    %__MODULE__{}
    |> cast(params, [:balance, :user_id])
    |> validate_required([:balance, :user_id])
    |> foreign_key_constraint(:user_id)
  end

  def withdraw_changeset(account, amount) when amount > 0 do
    account
    |> change(%{balance: account.balance - amount})
    |> check_constraint(:balance, name: :balance_must_be_nonnegative)
  end

  def deposit_changeset(account, amount) when amount > 0 do
    change(account, %{balance: account.balance + amount})
  end


end
