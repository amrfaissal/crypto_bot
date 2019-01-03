defmodule CryptoBot.Slack do
  @moduledoc false

  use Slack
  require Logger

  def handle_connect(slack, state) do
    Logger.info("#{__MODULE__} connected as #{slack.me.name}")
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    regex = ~r/(?<fsym>[\w+,\s]*)(\sin\s)(?<tsyms>[\w+,\s]*)/
    tokens = regex |> Regex.named_captures(message.text)

    if tokens do
      to_symbols =
        tokens
        |> Map.get("tsyms")
        |> String.split(",")
        |> Enum.map(&String.trim/1)

      with object = CryptoBot.provider().single_symbol_price(tokens["fsym"], to_symbols),
           {:ok, response} <- Jason.encode(object) do
        send_message("<@#{message.user}> #{response}", message.channel, slack)
      end
    else
      send_message("<@#{message.user}> I'm sorry, I don't understand!", message.channel, slack)
    end

    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}

  def handle_info(_, _, state), do: {:ok, state}
end
