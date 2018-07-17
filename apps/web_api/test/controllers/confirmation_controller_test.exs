defmodule WebApi.ConfirmationControllerTest do
  use WebApi.ConnCase

  test "Valid txhash GET /api/v1/confirmation/:id", %{conn: conn} do
    conn = get conn, "/api/v1/confirmation/0x7b6d0e8d812873260291c3f8a9fa99a61721a033a01e5c5af3ceb5e1dc9e7bd0"
    assert json_response(conn, 200) == %{"valid" => true}
  end

  test "Invalid txHash GET /api/v1/confirmation/:id", %{conn: conn} do
    conn = get conn, "/api/v1/confirmation/none"
    assert json_response(conn, 400) == %{"error" => "Transaction doesn't exist!"}
  end
end
