defmodule CryptoBot.Tokenizer do
  @moduledoc false

  def tokenize(str) do
    with {:ok, tokens, _} <- :tokenizer.string(to_charlist(str)),
         _ <- IO.inspect(tokens),
         {:ok, result} <- :parser.parse(tokens) do
      result
    else
      {:error, reason, _} -> reason
      {:error, {_, :parser, reason}} -> to_string(reason)
    end
  end
end
