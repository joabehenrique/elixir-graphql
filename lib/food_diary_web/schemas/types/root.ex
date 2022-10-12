defmodule FoodDiaryWeb.Schemas.Types.Root do
  use Absinthe.Schema.Notation

  alias FoodDiaryWeb.Resolvers.User, as: UsersResolver

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
    end

    @desc "Delete User"
    field :delete_user, :user do
      arg :id, non_null(:id)

      resolve &UsersResolver.delete/2
    end
  end
end
