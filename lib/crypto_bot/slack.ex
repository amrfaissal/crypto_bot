defmodule CryptoBot.Slack do
  @moduledoc false

  use Slack
  alias CryptoBot.{Helpers, Tokenizer}
  require Logger

  def handle_connect(slack, state) do
    Logger.info("#{__MODULE__} connected as #{slack.me.name}")
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    response_message =
      with {:ok, tokens} <- message.text |> strip() |> Tokenizer.tokenize(),
           {:ok, response} <- tokens |> handle_tokens() do
        """
        <@#{message.user}> :arrow_down: Here you go :arrow_down:

        #{Helpers.to_quote(response)}
        """
      else
        _ ->
          """
          <@#{message.user}> I'm sorry, I don't understand! :man-shrugging:
          """
      end

    send_message(response_message, message.channel, slack)

    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}

  def handle_info(_, _, state), do: {:ok, state}

  #
  # Helpers
  #

  defp handle_tokens({:fsym, list1, :tsym, list2}) do
    response =
      if length(list1) == 1 && length(list2) > 1 do
        CryptoBot.provider().single_symbol_price(list1, list2)
      else
        CryptoBot.provider().multiple_symbols_price(list1, list2)
      end

    {:ok, response}
  end

  defp strip(text) do
    text
    |> String.replace(~r/(<@[a-zA-Z0-9]*>\s*)/, "")
    |> HtmlEntities.decode()
  end
end
