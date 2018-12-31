defmodule CryptoBot.Slack do
  @moduledoc false

  use Slack

  require Logger

  def handle_connect(slack, state) do
    Logger.info("#{__MODULE__} Connected as #{slack.me.name}")
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    if Regex.run(~r/<@#{slack.me.id}>:?\sping/, message.text) do
      send_message("<@#{message.user}> pong", message.channel, slack)
    end

    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}

  def handle_info(_, _, state), do: {:ok, state}
end
