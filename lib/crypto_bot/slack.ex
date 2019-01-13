defmodule CryptoBot.Slack do
  @moduledoc false

  use Slack
  alias CryptoBot.Tokenizer
  require Logger

  def handle_connect(slack, state) do
    Logger.info("#{__MODULE__} connected as #{slack.me.name}")
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    with {:ok, tokens} <- message.text |> strip() |> Tokenizer.tokenize(),
         {:ok, response} <- tokens |> handle_tokens() do
      send_message("<@#{message.user}> #{response}", message.channel, slack)
    else
      _ ->
        send_message("<@#{message.user}> I'm sorry, I don't understand!", message.channel, slack)
    end

    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}

  def handle_info(_, _, state), do: {:ok, state}

  #
  # Helpers
  #

  defp handle_tokens({:fsym, list1, :tsym, list2}) do
    object =
      if length(list1) == 1 && length(list2) > 1 do
        CryptoBot.provider().single_symbol_price(list1, list2)
      else
        CryptoBot.provider().multiple_symbols_price(list1, list2)
      end

    Jason.encode(object)
  end

  defp strip(text) do
    text
    |> String.replace(~r/(<@[a-zA-Z0-9]*>\s*)/, "")
    |> HtmlEntities.decode()
  end
end
