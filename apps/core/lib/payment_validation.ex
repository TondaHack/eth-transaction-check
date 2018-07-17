defmodule Core.PaymentValidation do
  @moduledoc """
    Provides validation of ETH transaction.
  """
  require Logger
  alias Core.EtherscanApi

  def validate(txhash) do
    with {:ok, latest_block_number} <- get_data("action=eth_blockNumber"),
         {:ok, %{"blockNumber" => block_number}} <-
           get_data("action=eth_getTransactionByHash&txhash=#{txhash}") do
      {:ok, parse_hex(latest_block_number) - parse_hex(block_number) > 2}
    else
      {:error, reason} ->
        Logger.error(fn ->
          "No result for #{txhash}: #{inspect(reason)}"
        end)

        {:error, "Invalid Request"}
    end
  end

  defp get_data(url) do
    case EtherscanApi.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not Found"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp parse_hex("0x" <> hex) do
    {num, _rest} = Integer.parse(hex, 16)
    num
  end
end
