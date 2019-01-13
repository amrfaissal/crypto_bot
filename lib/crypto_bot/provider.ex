defmodule CryptoBot.Provider do
  @moduledoc """
  Behaviour to implement different providers of cryptocurrency pricing.
  """

  @type symbol :: String.t()
  @type symbols :: [String.t()]

  @callback single_symbol_price(symbol, symbols) :: map
  @callback multiple_symbols_price(symbols, symbols) :: map
  @callback encode(symbols) :: String.t()
end
