defmodule WebApi.ConfirmationController do
  use WebApi.Web, :controller
  alias Core.PaymentValidation

  def index(conn, %{"txhash" => txhash}) do
    case PaymentValidation.validate(txhash) do
      {:ok, validation} -> json(conn, %{valid: validation})
      {:error, reason} -> json(put_status(conn, :bad_request), %{error: reason})
    end
  end

  def index(conn, _bad_param) do
    json(put_status(conn, :bad_request), %{errors: "Bad Parameter!"})
  end
end
