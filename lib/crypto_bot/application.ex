defmodule CryptoBot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    api_key = Application.get_env(:crypto_bot, :slack)[:api_key]

    children = [
      worker(Slack.Bot, [CryptoBot.Slack, [], api_key])
    ]

    opts = [strategy: :one_for_one, name: CryptoBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
