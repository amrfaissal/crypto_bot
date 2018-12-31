defmodule CryptoBot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    token = Application.get_env(:crypto_bot, :slack_api_token)

    children = [
      worker(Slack.Bot, [CryptoBot.Slack, [], token])
    ]

    opts = [strategy: :one_for_one, name: CryptoBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
