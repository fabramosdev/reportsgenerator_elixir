defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "build report" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()

      expected_response = %{
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected_response
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the option is 'users', return the user who spent the most" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("users")

      expected_response = {:ok, {"5", 49}}

      assert response == expected_response
    end

    test "when the option is 'foods', return the most consumed food" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("foods")

      expected_response = {:ok, {"esfirra", 3}}

      assert response == expected_response
    end

    test "when the option is invalid, returns the error" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("bananas")

      expected_response =
        {:error, "Invalid option: The argument 'option' accept only 'users' OR 'foods'."}

      assert response == expected_response
    end
  end

  describe "fetch_lower_cost/2" do
    test "when the option is users, return who spent the least" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_lower_cost("users")

      expected_response = {:ok, {"11", 0}}

      assert response == expected_response
    end

    test "when the option is foods, return the least consumed food" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_lower_cost("foods")

      expected_response = {:ok, {"pastel", 0}}

      assert response == expected_response
    end

    test "when the option is invalid, returns the error" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_lower_cost("bananas")

      expected_response =
        {:error, "Invalid option: The argument 'option' accept only 'users' OR 'foods'."}

      assert response == expected_response
    end
  end
end
