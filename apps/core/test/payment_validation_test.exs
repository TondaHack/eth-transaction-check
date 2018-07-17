defmodule PaymentValidationTest do
  use ExUnit.Case
  alias Core.PaymentValidation
  import Mock

  test "Valid with mock" do
    with_mock Core.EtherscanApi,
      get: fn url ->
        case url do
          "action=eth_blockNumber" ->
            {:ok, %HTTPoison.Response{status_code: 200, body: {:ok, "0x3E8"}}}

          "action=eth_getTransactionByHash&txhash=transactionHash" ->
            {:ok, %HTTPoison.Response{status_code: 200, body: {:ok, %{"blockNumber" => "0x1F4"}}}}
        end
      end do
      assert {:ok, true} == PaymentValidation.validate("transactionHash")
    end
  end

  test "Invalid with mock" do
    with_mock Core.EtherscanApi,
      get: fn url ->
        case url do
          "action=eth_blockNumber" ->
            {:ok, %HTTPoison.Response{status_code: 200, body: {:ok, "0x1F4"}}}

          "action=eth_getTransactionByHash&txhash=transactionHash" ->
            {:ok, %HTTPoison.Response{status_code: 200, body: {:ok, %{"blockNumber" => "0x1F4"}}}}
        end
      end do
      assert {:ok, false} == PaymentValidation.validate("transactionHash")
    end
  end

  test "Not found request" do
    with_mock Core.EtherscanApi,
      get: fn url ->
        case url do
          "action=eth_blockNumber" ->
            {:ok, %HTTPoison.Response{status_code: 404}}

          "action=eth_getTransactionByHash&txhash=transactionHash" ->
            {:ok, %HTTPoison.Response{status_code: 200, body: {:ok, %{"blockNumber" => "0x1F4"}}}}
        end
      end do
      assert {:error, "Invalid Request"} == PaymentValidation.validate("transactionHash")
    end
  end
end
