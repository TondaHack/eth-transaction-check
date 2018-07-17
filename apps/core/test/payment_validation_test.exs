defmodule PaymentValidationTest do
  use ExUnit.Case
  alias Core.PaymentValidation
  doctest PaymentValidation

  test "Validate" do
    assert PaymentValidation.validate() == true
  end
end
