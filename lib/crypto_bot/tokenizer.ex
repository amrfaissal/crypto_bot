defmodule CryptoBot.Tokenizer do
  @moduledoc """
  Tokenizes a statement received from the bot based on the defined grammar.

  ## Examples

       iex> CryptoBot.Tokenizer.tokenize("price of xrp")
       {:ok, {:fsym, ["XRP"], :tsym, ["EUR"]}}

       iex> CryptoBot.Tokenizer.tokenize("btc & xrp to usd")
       {:ok, {:fsym, ["BTC", "XRP"], :tsym, ["USD"]}}

       iex> CryptoBot.Tokenizer.tokenize("price of btc and ltc")
       {:ok, {:fsym, ["BTC", "LTC"], :tsym, ["EUR"]}}

       iex> CryptoBot.Tokenizer.tokenize("ltc to mad and eur and usd")
       {:ok, {:fsym, ["LTC"], :tsym, ["MAD", "EUR", "USD"]}}
  """

  @spec tokenize(String.t()) :: tuple
  def tokenize(statement) do
    with {:ok, tokens, _} <- statement |> to_charlist() |> :tokenizer.string(),
         {:ok, result} <- tokens |> :parser.parse() do
      {:ok, result}
    else
      {:error, reason, _} -> {:error, reason}
      {:error, {_, :parser, reason}} -> {:error, to_string(reason)}
    end
  end
end
