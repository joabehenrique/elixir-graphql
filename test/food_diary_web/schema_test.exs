defmodule FoodDiaryWeb.SchemaTest do
  use FoodDiaryWeb.ConnCase, async: true

  alias FoodDiary.User
  alias FoodDiary.Users

  describe "users query" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "jobe@hotmail.com", name: "joabe"}

      {:ok, %User{id: user_id}} = Users.Create.call(params)

      query = """
        {
          user(id: "#{user_id}"){
            name,
            email
          }
        }
      """

      expected_response = %{
        "data" => %{"user" => %{"email" => "jobe@hotmail.com", "name" => "joabe"}}
      }

      response =
        conn
        |> post("api/graphql", %{query: query})
        |> json_response(200)

      assert response == expected_response
    end

    test "when the user does not exist, returns an error", %{conn: conn} do
      query = """
        {
          user(id: "#{123}"){
            name,
            email
          }
        }
      """

      expected_response = %{
        "data" => %{"user" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "User not found",
            "path" => ["user"]
          }
        ]
      }

      response =
        conn
        |> post("api/graphql", %{query: query})
        |> json_response(200)

      assert response == expected_response
    end
  end

  describe "users mutation" do
    test "when a valid id is given, creates the user", %{conn: conn} do
      mutation = """
        mutation{
          createUser(input: {email: "jobe@hotmail.com", name: "joabe"}){
            id,
            name,
            email
          }
        }
      """

      response =
        conn
        |> post("api/graphql", %{query: mutation})
        |> json_response(200)

      assert %{
               "data" => %{
                 "createUser" => %{"email" => "jobe@hotmail.com", "id" => _id, "name" => "joabe"}
               }
             } = response
    end
  end
end
