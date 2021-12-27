defmodule Banking.Account do
  use Ecto.Schema
  import Ecto.Changeset

  #campos que podem ser alterados
  @changeable_fields [
    :number,
    :balance
  ]

  #campos obrigatórios
  @required_fields [
    :number,
    :balance
  ]

  #Configurando o tipo de chave primária e geração automática
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "accounts" do
    field :number, :string
    field :balance, :integer

      timestamps()
  end

  def changeset(%{} = params) do
    %__MODULE__{}
    |> cast(params,@changeable_fields)
    |> validate_required(@required_fields)

  end

end
