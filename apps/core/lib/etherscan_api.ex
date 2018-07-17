defmodule Core.EtherscanApi do
  @moduledoc """
     Wraps HTTPoison.Base module to provide Etherscan API.
  """
  use HTTPoison.Base
  @api_key Application.get_env(:core, :api_url)
  @api_url Application.get_env(:core, :api_url)

  def process_url(url_params) do
    "#{@api_url}?module=proxy&#{url_params}&apikey=#{@api_key}"
  end

  def process_response_body(body) do
    body
    |> Poison.decode!()
    |> resolve_response()
  end

  defp resolve_response(%{"result" => result}) do
    {:ok, result}
  end

  defp resolve_response(_wrong_response) do
    {:error, "Transaction doesn't exist!"}
  end
end
