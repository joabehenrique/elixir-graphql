defmodule FoodDiaryWeb.Schemas.Types.Root do
  use Absinthe.Schema.Notation

  alias FoodDiaryWeb.Resolvers.User, as: UsersResolver
  alias FoodDiaryWeb.Resolvers.Meal, as: MealsResolver
  alias Crudry.Middlewares.TranslateErrors

  import_types FoodDiaryWeb.Schemas.Types.Meal
  import_types FoodDiaryWeb.Schemas.Types.User

  object :root_query do
    field :user, type: :user do
      arg :id, non_null(:id)

      resolve &UsersResolver.get/2
    end
  end

  object :root_mutation do
    @desc "Create User"
    field :create_user, :user do
      arg :input, non_null(:input_create_user)

      resolve &UsersResolver.create/2
      middleware TranslateErrors
    end

    @desc "Delete User"
    field :delete_user, :user do
      arg :id, non_null(:id)

      resolve &UsersResolver.delete/2
      middleware TranslateErrors
    end

    @desc "Create Meal"
    field :create_meal, :meal do
      arg :input, non_null(:create_meal_input)

      resolve &MealsResolver.create/2
      middleware TranslateErrors
    end
  end

  object :root_subscription do
    # field :new_meal, :meal do
    #   config fn _args, _info ->
    #     {:ok, topic: "new_meal_topic"}
    #   end
    # end

    #Com triggers
    field :new_meal, :meal do
      config fn _args, _info ->
        {:ok, topic: "new_meal_topic"}
      end

      trigger :create_meal, topic: fn _context -> ["new_meal_topic"] end
    end
  end
end
