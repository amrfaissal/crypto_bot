defmodule CryptoBot.CryptoCompare do
  @moduledoc """
  Gets the current price of any cryptocurrency in any other currency using CryptoCompare API.
  More info: https://min-api.cryptocompare.com/documentation
  """

  alias CryptoBot.HTTP

  @behaviour CryptoBot.Provider

  @impl true
  def single_symbol_price(from_symbol, to_symbols) do
    with fsym = from_symbol |> encode(),
         tsyms = to_symbols |> encode(),
         {:ok, 200, response} <- HTTP.get("price?fsym=#{fsym}&tsyms=#{tsyms}") do
      response
    end
  end

  @impl true
  def multiple_symbols_price(from_symbols, to_symbols) do
    with fsyms = from_symbols |> encode(),
         tsyms = to_symbols |> encode(),
         {:ok, 200, response} <- HTTP.get("pricemulti?fsyms=#{fsyms}&tsyms=#{tsyms}") do
      response
    end
  end

  @impl true
  def encode(symbols) do
    symbols |> Enum.map(&String.upcase/1) |> Enum.join(",")
  end
end
