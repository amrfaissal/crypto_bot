defmodule CryptoBot.Helpers do
  @moduledoc false

  def to_quote(input, ns) do
    input
    |> Enum.map(fn {key, value} -> parse("#{ns}/#{key}", value) end)
    |> Enum.join("\n")
  end

  def to_quote(input) do
    input
    |> Enum.map(fn {key, value} -> parse(key, value) end)
    |> Enum.join("\n")
  end

  def parse(key, value) when is_map(value) do
    to_quote(value, key)
  end

  def parse(key, value) do
    "> *#{key}* ~ #{value}"
  end
end
