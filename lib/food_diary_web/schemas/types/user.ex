defmodule FoodDiaryWeb.Schemas.Types.User do
  use Absinthe.Schema.Notation

  @desc "Types user auth"
  object :user do
    field :id, non_null(:id), description: "is a integer"
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :meals, list_of(:meal)
  end

  input_object :input_create_user do
    field :name, non_null(:string), description: "Users name"
    field :email, non_null(:string), description: "Users email"
  end
end
